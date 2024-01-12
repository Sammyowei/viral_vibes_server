import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context) {
  return Response(
    // 302 status code for redirection
    body: 'Welcome to Dart Frog!',
  );
}
