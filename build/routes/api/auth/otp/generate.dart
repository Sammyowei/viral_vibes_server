import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

import '../../../../src/otp/otp.dart';

Future<Response> onRequest(RequestContext context) async {
  final otpClient = context.read<OtpClient>();
  final request = context.request;

  final queryParam = request.url.queryParameters;

  final userEmai = queryParam['email'] ?? 'viralvibes@hawkitpro.com';

  final email = Uri.decodeComponent(userEmai);
  final otp = otpClient.generateOtp();

  return Response.json(
    body: 'your otp is: $otp, email = $email',
  );
}
