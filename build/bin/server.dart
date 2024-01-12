// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, implicit_dynamic_list_literal

import 'dart:io';

import 'package:dart_frog/dart_frog.dart';


import '../routes/index.dart' as index;
import '../routes/api/user/[id].dart' as api_user_$id;
import '../routes/api/service/services.dart' as api_service_services;
import '../routes/api/auth/verify.dart' as api_auth_verify;
import '../routes/api/auth/signup.dart' as api_auth_signup;
import '../routes/api/auth/signin.dart' as api_auth_signin;
import '../routes/api/auth/otp/generate.dart' as api_auth_otp_generate;
import '../routes/admin/index.dart' as admin_index;
import '../routes/admin/websockets/user_count.dart' as admin_websockets_user_count;

import '../routes/_middleware.dart' as middleware;

void main() async {
  final address = InternetAddress.anyIPv6;
  final port = int.tryParse(Platform.environment['PORT'] ?? '8080') ?? 8080;
  createServer(address, port);
}

Future<HttpServer> createServer(InternetAddress address, int port) async {
  final handler = Cascade().add(createStaticFileHandler()).add(buildRootHandler()).handler;
  final server = await serve(handler, address, port);
  print('\x1B[92m✓\x1B[0m Running on http://${server.address.host}:${server.port}');
  return server;
}

Handler buildRootHandler() {
  final pipeline = const Pipeline().addMiddleware(middleware.middleware);
  final router = Router()
    ..mount('/admin/websockets', (context) => buildAdminWebsocketsHandler()(context))
    ..mount('/admin', (context) => buildAdminHandler()(context))
    ..mount('/api/auth/otp', (context) => buildApiAuthOtpHandler()(context))
    ..mount('/api/auth', (context) => buildApiAuthHandler()(context))
    ..mount('/api/service', (context) => buildApiServiceHandler()(context))
    ..mount('/api/user', (context) => buildApiUserHandler()(context))
    ..mount('/', (context) => buildHandler()(context));
  return pipeline.addHandler(router);
}

Handler buildAdminWebsocketsHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/user_count', (context) => admin_websockets_user_count.onRequest(context,));
  return pipeline.addHandler(router);
}

Handler buildAdminHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/', (context) => admin_index.onRequest(context,));
  return pipeline.addHandler(router);
}

Handler buildApiAuthOtpHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/generate', (context) => api_auth_otp_generate.onRequest(context,));
  return pipeline.addHandler(router);
}

Handler buildApiAuthHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/verify', (context) => api_auth_verify.onRequest(context,))..all('/signup', (context) => api_auth_signup.onRequest(context,))..all('/signin', (context) => api_auth_signin.onRequest(context,));
  return pipeline.addHandler(router);
}

Handler buildApiServiceHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/services', (context) => api_service_services.onRequest(context,));
  return pipeline.addHandler(router);
}

Handler buildApiUserHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/<id>', (context,id,) => api_user_$id.onRequest(context,id,));
  return pipeline.addHandler(router);
}

Handler buildHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/', (context) => index.onRequest(context,));
  return pipeline.addHandler(router);
}

