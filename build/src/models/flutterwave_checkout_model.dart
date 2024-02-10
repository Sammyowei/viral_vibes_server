// To parse this JSON data, do
//
//     final flutterwaveCheckout = flutterwaveCheckoutFromJson(jsonString);

import 'dart:convert';

String flutterwaveCheckoutToJson(FlutterwaveCheckout data) =>
    json.encode(data.toJson());

class FlutterwaveCheckout {
  FlutterwaveCheckout({
    this.status,
    this.message,
    this.data,
  });

  factory FlutterwaveCheckout.fromJson(Map<String, dynamic> json) =>
      FlutterwaveCheckout(
        status: json['status'] as String?,
        message: json['message'] as String?,
        data: json['data'] == null
            ? null
            : FlutterwaveCheckoutData.fromJson(
                json['data'] as Map<String, dynamic>,
              ),
      );

  String? status;
  String? message;
  FlutterwaveCheckoutData? data;

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data?.toJson(),
      };
}

class FlutterwaveCheckoutData {
  FlutterwaveCheckoutData({
    this.link,
  });
  factory FlutterwaveCheckoutData.fromJson(Map<String, dynamic> json) =>
      FlutterwaveCheckoutData(
        link: json['link'] as String,
      );
  String? link;

  Map<String, dynamic> toJson() => {
        'link': link,
      };
}
