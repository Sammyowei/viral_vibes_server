// Copyright 2023, the Hawkit Pro project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: lines_longer_than_80_chars

// Import necessary Dart libraries and packages.
import 'dart:convert';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

// Import required project files.
import '../../../src/authentication/authentication_controller.dart';
import '../../../src/authentication/signup_authentication_state_data.dart';
import '../../../src/db/db_controller.dart';
import '../../../src/mail/smpt_mailer/smpt_mailer.dart';
import '../../../src/mail/templates/account_creation_email_template.dart';
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

  // Create an instance of SignUpAuthenticationStateData from the JSON payload.
  final signUpAuthenticationStateData = SignUpAuthenticationStateData.fromJson(
    jsonPayload as Map<String, dynamic>,
  );

  // Check for null values in the signup data.
  final isCredentialsNull = signUpAuthenticationStateData.checkForNullValue();

  // If any required field is null, return an error response.
  final validCredential = isCredentialsNull['message'];

  if (validCredential == null) {
    return Response.json(
      body: {'error': isCredentialsNull},
      statusCode: HttpStatus.badRequest,
    );
  }

  // Validate the email address format.
  final isEmailValid = signUpAuthenticationStateData.isEmailValid();

  if (isEmailValid == false) {
    return Response.json(
      body: {'error': 'Please provide a valid email address'},
      statusCode: HttpStatus.badRequest,
    );
  }

  // Communicate with the database middleware to open a connection and perform signup.
  final db = await context.read<Future<DbController>>();

  final authClient = AuthenticationController(
    dbController: db,
    emailAddress: signUpAuthenticationStateData.email!,
    password: signUpAuthenticationStateData.password!,
    mobileNumber: signUpAuthenticationStateData.mobileNumber!,
    userName: signUpAuthenticationStateData.userName!,
  );

  // Sign up using authentication logic.
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

  // If successful signup, prepare and send an account creation email notification.
  final mailer = SmptMailer();
  final userData = response['detail'];
  final user = User.fromJson(userData as Map<String, dynamic>);

  final createAccountMail = accountCreationEmailTemplate(
    email: user.emailAddress,
  );
  await mailer.sendMail(
    email: user.emailAddress,
    messageContent: createAccountMail,
    senderName: 'Viral Vibes',
    messageSubject: ' Welcome to Viral Vibe, Viber! 🚀',
  );

  // Return the response from the signup process.
  return Response.json(
    body: response,
  );
}
