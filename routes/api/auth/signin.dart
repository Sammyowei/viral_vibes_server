// ignore_for_file: lines_longer_than_80_chars

import 'dart:convert';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

import '../../../src/authentication/authentication_controller.dart';
import '../../../src/authentication/authentication_state.dart';
import '../../../src/db/db_controller.dart';

Future<Response> onRequest(RequestContext context) async {
  // TODO: First check the Request Method and ensure it is a Post MEthod

  final method = context.request.method;

  if (method != HttpMethod.post) {
    return Response.json(
      body: {'error': 'Request Method Should be POST'},
      statusCode: HttpStatus.forbidden,
    );
  }

// Get Data from the request body and Validate that the data gotten is not empty or null,

  final requestBody = await context.request.body();

  if (requestBody.isEmpty) {
    return Response.json(
      body: {'error': 'Required a request body of JSON data'},
      statusCode: HttpStatus.badRequest,
    );
  }

  final jsonPayload = jsonDecode(requestBody);

  final loginAuthenticationData = LoginAuthenticationStateData.fromJson(
    jsonPayload as Map<String, dynamic>,
  );

  final isEmailOrPasswordNull = loginAuthenticationData.checkForNullValue();

  final noNullValueMessage = isEmailOrPasswordNull['message'];
  if (noNullValueMessage == null) {
    return Response.json(
      body: {'error': isEmailOrPasswordNull},
      statusCode: HttpStatus.badRequest,
    );
  }

  // Validate the email address

  final isEmailValid = loginAuthenticationData.isEmailValid();
  if (isEmailValid == false) {
    return Response.json(
      body: {'error': 'Please provide a valid email address'},
      statusCode: HttpStatus.badRequest,
    );
  }

  // Open Db MiddleWare and perform authentication logic

  final db = await context.read<Future<DbController>>();

  final authClient = AuthenticationController(
    dbController: db,
    emailAddress: loginAuthenticationData.email!,
    password: loginAuthenticationData.password!,
  );

  final response = await authClient.signIn();

  final isErrorResponse = response['error'];

  if (isErrorResponse != null) {
    return Response.json(
      body: {
        'error': isErrorResponse,
      },
      statusCode: HttpStatus.badGateway,
    );
  }

  return Response.json(
    body: response,
  );
}
