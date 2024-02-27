// ignore_for_file: unused_local_variable, lines_longer_than_80_chars

import 'dart:convert';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../../src/checkout/flutterwave_checkout_client.dart';

import '../../src/models/flutterwave_checkout_model.dart';
import '../../src/models/flutterwave_webhook_model.dart';
import '../../src/src.dart';

Future<Response> onRequest(RequestContext context) async {
  final queryParam = context.request.uri.queryParameters;

  final flwhData = FlutterwavewebhookData.fromJson(queryParam);

  if (flwhData.status == 'cancelled') {
    return Response.json(
      body: {
        'error': 'Failed Transaction',
      },
      statusCode: HttpStatus.forbidden,
    );
  }

  final flwcheckoutClient = FlutterwaveCheckoutClient();

  final response = await flwcheckoutClient.validate(flwhData.transactionId!);

  final amount = response?.data?.amount;

  print(response?.data?.toJson());
  final accountID = response!.data!.customer!.email;

  final db = await context.read<Future<DbController>>();

  await db.openConnection();
  final data = await db.read(accountID!);
  await db.closeConnection();

  if (data == null) {
    return Response.json(
      // 302 status code for redirection
      body: {'error': 'Not Authorised'},
      statusCode: HttpStatus.badGateway,
    );
  }

  final user = User.fromJson(data);

  if (user.isReferred == true && user.transactionHistory.isEmpty) {
    final referee = user.referee;

    await db.openConnection();
    final refereeData = await db.read(referee!);
    await db.closeConnection();

    if (refereeData != null) {
      final refererUser = User.fromJson(refereeData);

      final percentage = amount! * 0.1;

      final referalTransaction = Transactions(
        amount: amount,
        dateTime: DateTime.now(),
        method: 'Referral Bonus',
        referenceId: const Uuid().v4(),
        status: 'successful',
      );

      refererUser
        ..deposit(percentage)
        ..addTransaction(referalTransaction);
      await db.openConnection();
      await db.update(referee, refererUser.toJson());
      await db.closeConnection();
    }
  }

  // Continue deposit for user if not first

  var newAmount = amount!;

  if (user.isReferred && user.transactionHistory.isEmpty) {
    newAmount = amount + (amount * 0.1);
  }
  final transaction = Transactions(
    amount: newAmount,
    dateTime: DateTime.now(),
    method: 'Cash Deposit',
    referenceId: const Uuid().v4(),
    status: response.data!.status!,
  );

  if (response.data!.status! == 'successful') {
    user.deposit(amount);
  }
  user.addTransaction(transaction);
  // user.

  await db.openConnection();
  await db.update(accountID, user.toJson());
  await db.closeConnection();
  return Response.movedPermanently(
    location: 'https://api.viralvibes.hawkitpro.com/dashboard',
    body: jsonEncode(
      user.toJson(),
    ),
  );
}
