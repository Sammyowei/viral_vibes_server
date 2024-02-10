import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';

import '../../../src/src.dart';

Future<Response> onRequest(RequestContext context) async {
  final request = context.request;

  final queryParam = request.url.queryParameters;

  final id = queryParam['id'];

  final serviceMiddleware = await context.read<Future<ServiceProvider>>();
  final userDb = await context.read<Future<DbController>>();

  serviceMiddleware
    ..accountID = id
    ..dbcontroller = userDb;
  final response = await serviceMiddleware.orderStatus();

  return Response.json(
    body: response,
  );
}
