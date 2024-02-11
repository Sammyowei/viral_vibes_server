import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

import '../../../src/checkout/flutterwave_checkout_client.dart';
import '../../../src/db/db_controller.dart';
import '../../../src/models/flutterwave_model.dart';
import '../../../src/user/user.dart';

Future<Response> onRequest(RequestContext context) async {
  final request = context.request;

  final queryParam = request.uri.queryParameters;

  final data = ReqData.fromJson(queryParam);

  final validData = data.validData();

  if (validData == false) {
    return Response.json(
      body: {'error': 'one or two parameters are missing'},
      statusCode: HttpStatus.badGateway,
    );
  }

  final db = await context.read<Future<DbController>>();
  final userController = UserController(
    identifier: data.accountID!,
    controller: db,
  );

  final user = await userController.getUser();
  final flutterwaveCheckoetClient = FlutterwaveCheckoutClient();

  final constomer = FlutterwaveCustomer(
    email: user!.emailAddress,
    phonenumber: user.mobileNumber,
    name: user.userName,
  );
  final response = await flutterwaveCheckoetClient.initializeCheckout(
    constomer,
    amount: data.amount!,
  );
  return Response.json(
    // 302 status code for redirection
    body: response,
  );
}

class ReqData {
  ReqData({
    required this.accountID,
    required this.amount,
  });

  final String? accountID;
  final String? amount;

  factory ReqData.fromJson(Map<String, dynamic> json) {
    return ReqData(
      accountID: json['accountId'] as String?,
      amount: json['amount'] as String?,
    );
  }

  bool validData() {
    if (accountID == null || amount == null) {
      return false;
    } else {
      return true;
    }
  }
}
