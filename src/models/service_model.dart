// Copyright 2023, the Hawkit Pro project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: lines_longer_than_80_chars

class Service {
  Service({
    required this.serviceId,
    required this.name,
    required this.type,
    required this.category,
    required this.rate,
    required this.min,
    required this.max,
    required this.dripFeed,
    required this.refill,
    required this.cancel,
  });
  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      serviceId: json['service'] as int,
      name: json['name'] as String,
      type: json['type'] as String,
      category: json['category'] as String,
      rate: json['rate'] as String,
      min: json['min'] as String,
      max: json['max'] as String,
      refill: json['refill'] as bool,
      cancel: json['cancel'] as bool,
      dripFeed: json['dripfeed'] as bool,
    );
  }

  final int serviceId;
  final String name;
  String type;
  String category;
  String rate;
  final String min;
  final String max;
  final bool refill;
  final bool cancel;
  final bool dripFeed;

// Converts the Service model to a json format.
  Map<String, dynamic> toJson() {
    return {
      'service': serviceId,
      'name': name,
      'type': type,
      'category': category,
      'rate': rate,
      'min': min,
      'max': max,
      'refill': refill,
      'cancel': cancel,
      'dripfeed': dripFeed,
    };
  }

  /// Converts the current rate in dollar to naira  and updates the value of [rate]
  void convertRate(double dollarRate) {
    final _rate = double.parse(rate);
    final newRate = (_rate * dollarRate) + ((_rate * dollarRate) * 0.9) + 100;
    rate = newRate.toString();
  }
}
