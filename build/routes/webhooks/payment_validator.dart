import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';

import '../../src/models/flutterwave_webhook_model.dart';

Future<Response> onRequest(RequestContext context) async {
  final data = await context.request.body();

  final jsonPayload = jsonDecode(data);

  final flutterwaveWebhookData =
      FlutterWaveWebhook.fromJson(jsonPayload as Map<String, dynamic>);
  return Response.json(
    // 302 status code for redirection
    body: flutterwaveWebhookData.toJson(),
  );
}
