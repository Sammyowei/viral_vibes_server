import 'dart:convert';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

import '../../../src/models/order_request_model.dart';
import '../../../src/src.dart';

Future<Response> onRequest(RequestContext context) async {
  final request = context.request;

  if (request.method != HttpMethod.post) {
    return Response.json(
      body: {'error': 'Requires a Post Method'},
      statusCode: HttpStatus.badGateway,
    );
  }

  final body = await request.body();

  final deccodedBody = jsonDecode(body);

  final reqOrderModel =
      RequestOrderModel.fromJson(deccodedBody as Map<String, dynamic>);

  final reqError = reqOrderModel.validate();

  if (reqError != null) {
    return Response.json(
      body: reqError,
      statusCode: HttpStatus.badGateway,
    );
  }

  final service = await context.read<Future<ServiceProvider>>();
  final db = await context.read<Future<DbController>>();
  final order = reqOrderModel.order;

  service
    ..accountID = reqOrderModel.accountId
    ..dbcontroller = db;

  print(service.accountID);

  final serviceResponse = await service.addOrder(
    order!.serviceID!,
    order.link!,
    order.quantity!,
  );

  final error = serviceResponse['error'];

  if (error != null) {
    return Response.json(
      body: {'error': error},
      statusCode: HttpStatus.connectionClosedWithoutResponse,
    );
  }

  return Response.json(
    body: serviceResponse,
  );
}
