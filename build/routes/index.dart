import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  return Response(
    statusCode: HttpStatus.found, // 302 status code for redirection
    headers: {
      'Location':
          '/api/mailer/account_creation?email=samuelsonowei04@gmail.com',
    },
  );
}
