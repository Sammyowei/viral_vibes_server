// ignore_for_file: lines_longer_than_80_chars

import 'dart:convert';
import 'dart:io';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:viral_vibes_server/lib.dart';

import '../models/flutterwave_checkout_model.dart';
import '../models/flutterwave_model.dart';
import '../models/flutterwave_webhook_model.dart';
import '../network/network_client.dart';

class FlutterwaveCheckoutClient {
  FlutterwaveCheckoutClient();

  final fluttterwaveClientCommunicator =
      NetworkHttpClient(baseUrl: 'https://api.flutterwave.com');

  Future<Map<String, dynamic>?> initializeCheckout(
    FlutterwaveCustomer customer, {
    required String amount,
  }) async {
    final uuid = const Uuid();
    final flutterWaveModel = FlutterWaveModel(
      customer: customer,
      amount: amount,
      currency: 'NGN',
      txRef: uuid.v4(),
      meta: Meta(
        consumerId: customer.email,
      ),
      customizations: Customizations(
        title: 'Viral Vibes (${customer.name})',
        logo: 'https://api.viralvibes.hawkitpro.com/images/logo.png',
      ),
      redirectUrl:
          'https://api.viralvibes.hawkitpro.com/webhooks/payment_validator',
    );

// perform the network request

    try {
      final data = jsonEncode(flutterWaveModel.toJson());

      print(data);
      final response = await fluttterwaveClientCommunicator.postRequest(
        'v3/payments',
        data,
        headers: {
          'Authorization': 'Bearer ${Env.flutterwaveSecretTest}',
          HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
        },
      );

      final decodedBody = jsonDecode(response.body);

      final checkout = FlutterwaveCheckout.fromJson(
        decodedBody as Map<String, dynamic>,
      );

      return decodedBody;
    } catch (err) {
      throw ArgumentError();
    }
  }

  Future<FlutterWaveWebhook?> validate(String transactionID) async {
    try {
      final header = {
        HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
        HttpHeaders.authorizationHeader: 'Bearer ${Env.flutterwaveSecretTest}'
      };
      final response = await fluttterwaveClientCommunicator.getRequest(
        'v3/transactions/$transactionID/verify',
        headers: header,
      );

      final data = jsonDecode(response.body);

      return FlutterWaveWebhook.fromJson(data as Map<String, dynamic>);
    } catch (error) {
      return null;
    }
  }
}
