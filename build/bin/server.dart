// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, implicit_dynamic_list_literal

import 'dart:io';

import 'package:dart_frog/dart_frog.dart';


import '../routes/index.dart' as index;
import '../routes/api/service/services.dart' as api_service_services;
import '../routes/api/auth/signup.dart' as api_auth_signup;
import '../routes/api/auth/signin.dart' as api_auth_signin;

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
    ..mount('/api/auth', (context) => buildApiAuthHandler()(context))
    ..mount('/api/service', (context) => buildApiServiceHandler()(context))
    ..mount('/', (context) => buildHandler()(context));
  return pipeline.addHandler(router);
}

Handler buildApiAuthHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/signup', (context) => api_auth_signup.onRequest(context,))..all('/signin', (context) => api_auth_signin.onRequest(context,));
  return pipeline.addHandler(router);
}

Handler buildApiServiceHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/services', (context) => api_service_services.onRequest(context,));
  return pipeline.addHandler(router);
}

Handler buildHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/', (context) => index.onRequest(context,));
  return pipeline.addHandler(router);
}

