// Copyright 2023, the Hawkit Pro project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: lines_longer_than_80_chars, flutter_style_todos

// Import necessary Dart libraries and packages.
import 'dart:convert';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

// Import required project files.
import '../../../src/authentication/authentication_controller.dart';
import '../../../src/authentication/login_authentication_state_data.dart';
import '../../../src/db/db_controller.dart';
import '../../../src/mail/smpt_mailer/smpt_mailer.dart';
import '../../../src/mail/templates/login_email_template.dart';
import '../../../src/models/user_model.dart';

// Define an asynchronous function to handle incoming requests.
Future<Response> onRequest(RequestContext context) async {
  // Retrieve the HTTP request method.
  final method = context.request.method;

  // Check if the request method is not POST, return an error response if so.
  if (method != HttpMethod.post) {
    return Response.json(
      body: {'error': 'Request Method Should be POST'},
      statusCode: HttpStatus.forbidden,
    );
  }

  // Get data from the request body and ensure it's not empty.
  final requestBody = await context.request.body();

  if (requestBody.isEmpty) {
    return Response.json(
      body: {'error': 'Required a request body of JSON data'},
      statusCode: HttpStatus.badRequest,
    );
  }

  // Decode the JSON payload from the request body into a Dart object.
  final jsonPayload = jsonDecode(requestBody);

  // Create an instance of LoginAuthenticationStateData from the JSON payload.
  final loginAuthenticationData = LoginAuthenticationStateData.fromJson(
    jsonPayload as Map<String, dynamic>,
  );

  // Check for null values in the login data.
  final isEmailOrPasswordNull = loginAuthenticationData.checkForNullValue();

  // If any required field is null, return an error response.
  final noNullValueMessage = isEmailOrPasswordNull['message'];
  if (noNullValueMessage == null) {
    return Response.json(
      body: {'error': isEmailOrPasswordNull},
      statusCode: HttpStatus.badRequest,
    );
  }

  // Validate the email address format.
  final isEmailValid = loginAuthenticationData.isEmailValid();
  if (isEmailValid == false) {
    return Response.json(
      body: {'error': 'Please provide a valid email address'},
      statusCode: HttpStatus.badRequest,
    );
  }

  // Open a database middleware and perform authentication logic.
  final db = await context.read<Future<DbController>>();

  final authClient = AuthenticationController(
    dbController: db,
    emailAddress: loginAuthenticationData.email!,
    password: loginAuthenticationData.password!,
  );

  // Sign in using authentication logic.
  final response = await authClient.signIn();

  // Check if there's an error response from the authentication process.
  final isErrorResponse = response['error'];

  if (isErrorResponse != null) {
    return Response.json(
      body: {
        'error': isErrorResponse,
      },
      statusCode: HttpStatus.badGateway,
    );
  }

  // If successful authentication, prepare and send an email notification.
  final mailer = SmptMailer();
  final userData = response['detail'];
  final user = User.fromJson(userData as Map<String, dynamic>);

  final createAccountMail = loginEmailNotificationTemplate(
    email: user.emailAddress,
    userName: user.userName,
  );

  await mailer.sendMail(
    email: user.emailAddress,
    messageContent: createAccountMail,
    senderName: 'Viral Vibes',
    messageSubject: 'New login to Viral Vibes 🚀',
  );

  // Return the response from the authentication process.
  return Response.json(
    body: response,
  );
}
