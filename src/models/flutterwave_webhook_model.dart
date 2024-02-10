// To parse this JSON data, do
//
//     final flutterWaveWebhook = flutterWaveWebhookFromJson(jsonString);

import 'dart:convert';

String flutterWaveWebhookToJson(FlutterWaveWebhook data) =>
    json.encode(data.toJson());

class FlutterWaveWebhook {
  FlutterWaveWebhook({
    this.event,
    this.data,
  });

  factory FlutterWaveWebhook.fromJson(Map<String, dynamic> json) =>
      FlutterWaveWebhook(
        event: json['event'] as String?,
        data: json['data'] as Data?,
      );

  String? event;
  Data? data;

  Map<String, dynamic> toJson() => {
        'event': event,
        'data': data?.toJson(),
      };
}

class Data {
  Data({
    this.id,
    this.txRef,
    this.flwRef,
    this.deviceFingerprint,
    this.amount,
    this.currency,
    this.chargedAmount,
    this.appFee,
    this.merchantFee,
    this.processorResponse,
    this.authModel,
    this.ip,
    this.narration,
    this.status,
    this.paymentType,
    this.createdAt,
    this.accountId,
    this.customer,
    this.card,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['id'] as int?,
        txRef: json['tx_ref'] as String?,
        flwRef: json['flw_ref'] as String?,
        deviceFingerprint: json['device_fingerprint'] as String?,
        amount: json['amount'] as int?,
        currency: json['currency'] as String?,
        chargedAmount: json['charged_amount'] as int?,
        appFee: json['app_fee'] as double?,
        merchantFee: json['merchant_fee'] as int?,
        processorResponse: json['processor_response'] as String?,
        authModel: json['auth_model'] as String?,
        ip: json['ip'] as String?,
        narration: json['narration'] as String?,
        status: json['status'] as String?,
        paymentType: json['payment_type'] as String?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        accountId: json['account_id'] as int?,
        customer: json['customer'] == null
            ? null
            : Customer.fromJson(json['customer'] as Map<String, dynamic>),
        card: json['card'] == null
            ? null
            : Card.fromJson(json['card'] as Map<String, dynamic>),
      );
  int? id;
  String? txRef;
  String? flwRef;
  String? deviceFingerprint;
  int? amount;
  String? currency;
  int? chargedAmount;
  double? appFee;
  int? merchantFee;
  String? processorResponse;
  String? authModel;
  String? ip;
  String? narration;
  String? status;
  String? paymentType;
  DateTime? createdAt;
  int? accountId;
  Customer? customer;
  Card? card;

  Map<String, dynamic> toJson() => {
        'id': id,
        'tx_ref': txRef,
        'flw_ref': flwRef,
        'device_fingerprint': deviceFingerprint,
        'amount': amount,
        'currency': currency,
        'charged_amount': chargedAmount,
        'app_fee': appFee,
        'merchant_fee': merchantFee,
        'processor_response': processorResponse,
        'auth_model': authModel,
        'ip': ip,
        'narration': narration,
        'status': status,
        'payment_type': paymentType,
        'created_at': createdAt?.toIso8601String(),
        'account_id': accountId,
        'customer': customer?.toJson(),
        'card': card?.toJson(),
      };
}

class Card {
  Card({
    this.first6Digits,
    this.last4Digits,
    this.issuer,
    this.country,
    this.type,
    this.expiry,
  });

  factory Card.fromJson(Map<String, dynamic> json) => Card(
        first6Digits: json['first_6digits'] as String?,
        last4Digits: json['last_4digits'] as String?,
        issuer: json['issuer'] as String?,
        country: json['country'] as String?,
        type: json['type'] as String?,
        expiry: json['expiry'] as String?,
      );
  String? first6Digits;
  String? last4Digits;
  String? issuer;
  String? country;
  String? type;
  String? expiry;

  Map<String, dynamic> toJson() => {
        'first_6digits': first6Digits,
        'last_4digits': last4Digits,
        'issuer': issuer,
        'country': country,
        'type': type,
        'expiry': expiry,
      };
}

class Customer {
  Customer({
    this.id,
    this.name,
    this.phoneNumber,
    this.email,
    this.createdAt,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json['id'] as int?,
        name: json['name'] as String?,
        phoneNumber: json['phone_number'] as String?,
        email: json['email'] as String?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
      );
  int? id;
  String? name;
  dynamic phoneNumber;
  String? email;
  DateTime? createdAt;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'phone_number': phoneNumber,
        'email': email,
        'created_at': createdAt?.toIso8601String(),
      };
}
