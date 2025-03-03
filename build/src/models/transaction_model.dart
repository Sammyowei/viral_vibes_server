// Copyright 2023, the Hawkit Pro project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: sort_constructors_first, lines_longer_than_80_chars

class Transactions {
  Transactions({
    required this.amount,
    required this.dateTime,
    required this.method,
    required this.referenceId,
    required this.status,
  });

  final num amount;
  final DateTime dateTime;
  final String referenceId;
  final String method;
  final String status;

  factory Transactions.fromJson(Map<String, dynamic> json) {
    return Transactions(
      amount: json['amount'] as num,
      dateTime: DateTime.parse(json['dateTime'].toString()),
      referenceId: json['referenceId'] as String,
      method: json['method'] as String,
      status: json['status'] as String,
    );
  }

  factory Transactions.fromQueryParam(String queryParam) {
    final params = Uri.splitQueryString(queryParam);
    return Transactions(
      amount: double.parse(params['amount']!),
      dateTime: DateTime.parse(params['dateTime']!),
      referenceId: params['referenceId']!,
      method: params['method']!,
      status: params['status']!,
    );
  }

  factory Transactions.fromRequestQueryParams(
      Map<String, String?> queryParams) {
    return Transactions(
      amount: double.parse(queryParams['amount']!),
      dateTime: DateTime.parse(queryParams['dateTime']!),
      referenceId: queryParams['referenceId']!,
      method: queryParams['method']!,
      status: queryParams['status']!,
    );
  }

  // Convert Transactions to query parameter string
  String toQueryParam() {
    return 'amount=$amount&dateTime=${dateTime.toIso8601String()}&referenceId=$referenceId&method=$method&status$status';
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'dateTime': dateTime.toIso8601String(),
      'referenceId': referenceId,
      'method': method,
      'status': status
    };
  }
}
