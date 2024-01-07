import 'dart:convert';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

import '../../../src/authentication/authentication_controller.dart';
import '../../../src/authentication/signup_authentication_state_data.dart';
import '../../../src/db/db_controller.dart';

Future<Response> onRequest(RequestContext context) async {
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

  final signUpAuthenticationStateData = SignUpAuthenticationStateData.fromJson(
    jsonPayload as Map<String, dynamic>,
  );

  final isCredentialsNull = signUpAuthenticationStateData.checkForNullValue();

  final validCredential = isCredentialsNull['message'];
// TODO: CHeck and validate if the credentials ae not null
  if (validCredential == null) {
    return Response.json(
      body: {'error': isCredentialsNull},
      statusCode: HttpStatus.badRequest,
    );
  }

  // TODO: check if the email value of the credentials is valid

  final isEmailValid = signUpAuthenticationStateData.isEmailValid();

  if (isEmailValid == false) {
    return Response.json(
      body: {'error': 'Please provide a valid email address'},
      statusCode: HttpStatus.badRequest,
    );
  }

// TODO: Communicate with Db Middleware to open connection.

  final db = await context.read<Future<DbController>>();

  final authClient = AuthenticationController(
    dbController: db,
    emailAddress: signUpAuthenticationStateData.email!,
    password: signUpAuthenticationStateData.password!,
    mobileNumber: signUpAuthenticationStateData.mobileNumber!,
    userName: signUpAuthenticationStateData.userName!,
  );

  final response = await authClient.signUp();
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
