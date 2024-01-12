import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

import '../../../src/authentication/authentication_controller.dart';
import '../../../src/db/db_controller.dart';
import '../../../src/otp/otp.dart';

Future<Response> onRequest(RequestContext context) async {
  final otpClient = context.read<OtpClient>();
  final request = context.request;

  final param = request.url.queryParameters;

  final otp = param['otp'] ?? '000000';

  print(otp);
  final isOtpValid = otpClient.verifyOtp(otp);

  if (isOtpValid == false) {
    return Response.json(
      statusCode: HttpStatus.badRequest,
      body: {'error': 'Your OTP Has Expired – Please Request a New One'},
    );
  }

  final db = await context.read<Future<DbController>>();
  final email = param['email'] ?? 'samuelsonowei04@gmail.com';

  final authController = AuthenticationController(
    dbController: db,
    emailAddress: email,
  );

  final response = await authController.verifyaccount();

  final error = response['error'];
  if (error != null) {
    return Response.json(
      statusCode: HttpStatus.badRequest,
      body: response,
    );
  }
  return Response.json(body: response);
}
