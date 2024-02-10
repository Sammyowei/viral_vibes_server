// To parse this JSON data, do
//
//     final flutterWaveModel = flutterWaveModelFromJson(jsonString);

// ignore_for_file: use_setters_to_change_properties

import 'dart:convert';

String flutterWaveModelToJson(FlutterWaveModel data) =>
    json.encode(data.toJson());

class FlutterWaveModel {
  FlutterWaveModel({
    this.txRef,
    this.amount,
    this.currency,
    this.redirectUrl,
    this.meta,
    this.customer,
    this.customizations,
  });

  factory FlutterWaveModel.fromJson(Map<String, dynamic> json) =>
      FlutterWaveModel(
        txRef: json['tx_ref'] as String?,
        amount: json['amount'] as String?,
        currency: json['currency'] as String?,
        redirectUrl: json['redirect_url'] as String?,
        meta: json['meta'] == null
            ? null
            : Meta.fromJson(json['meta'] as Map<String, dynamic>),
        customer: json['customer'] == null
            ? null
            : FlutterwaveCustomer.fromJson(
                json['customer'] as Map<String, dynamic>),
        customizations: json['customizations'] == null
            ? null
            : Customizations.fromJson(
                json['customizations'] as Map<String, dynamic>,
              ),
      );

  String? txRef;
  String? amount;
  String? currency;
  String? redirectUrl;
  Meta? meta;
  FlutterwaveCustomer? customer;
  Customizations? customizations;

  Map<String, dynamic> toJson() => {
        'tx_ref': txRef,
        'amount': amount,
        'currency': currency,
        'redirect_url': redirectUrl,
        'meta': meta?.toJson(),
        'customer': customer?.toJson(),
        'customizations': customizations?.toJson(),
      };
}

class FlutterwaveCustomer {
  FlutterwaveCustomer({
    this.email,
    this.phonenumber,
    this.name,
  });

  factory FlutterwaveCustomer.fromJson(Map<String, dynamic> json) =>
      FlutterwaveCustomer(
        email: json['email'] as String?,
        phonenumber: json['phonenumber'] as String?,
        name: json['name'] as String?,
      );
  String? email;
  String? phonenumber;
  String? name;

  FlutterwaveCustomer copyWith(FlutterwaveCustomer consumer) {
    return FlutterwaveCustomer.fromJson(consumer.toJson());
  }

  Map<String, dynamic> toJson() => {
        'email': email,
        'phonenumber': phonenumber,
        'name': name,
      };
}

class Customizations {
  Customizations({
    this.title,
    this.logo,
  });

  factory Customizations.fromJson(Map<String, dynamic> json) => Customizations(
        title: json['title'] as String?,
        logo: json['logo'] as String?,
      );
  String? title;
  String? logo;

  void setTitle(String? value) => title = value;

  void setLogo(String? logoPath) => logo = logoPath;

  Map<String, dynamic> toJson() => {
        'title': title,
        'logo': logo,
      };
}

class Meta {
  Meta({
    this.consumerId,
    this.consumerMac,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        consumerId: json['consumer_id'] as int?,
        consumerMac: json['consumer_mac'] as String?,
      );
  int? consumerId;
  String? consumerMac;

  void setconsumerId(int? consId) => consumerId = consId;

  void setconsumerMac(String? consMac) => consumerMac = consMac;

  Map<String, dynamic> toJson() => {
        'consumer_id': consumerId,
        'consumer_mac': consumerMac,
      };
}
