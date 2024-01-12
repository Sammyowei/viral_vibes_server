// Copyright 2023, the Hawkit Pro project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: sort_constructors_first

class OrderModel {
  OrderModel({required this.id, required this.link, DateTime? createdAt})
      : _createdAt = createdAt ?? DateTime.now();

  final int id;
  final String link;
  final DateTime _createdAt;

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] as int,
      link: json['link'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'link': link,
      'createdAt': _createdAt.toIso8601String(),
    };
  }

  // Convert OrderModel to query parameter string
  String toQueryParam() {
    return 'id=$id&link=$link&createdAt=${_createdAt.toIso8601String()}';
  }

  // Create OrderModel object from query parameters
  factory OrderModel.fromQueryParam(String queryParam) {
    final params = Uri.splitQueryString(queryParam);
    return OrderModel(
      id: int.parse(params['id']!),
      link: params['link']!,
      createdAt: DateTime.parse(params['createdAt']!),
    );
  }

  // Create OrderModel object from request query parameters
  factory OrderModel.fromRequestQueryParams(Map<String, String?> queryParams) {
    return OrderModel(
      id: int.parse(queryParams['id']!),
      link: queryParams['link']!,
      createdAt: DateTime.parse(queryParams['createdAt']!),
    );
  }
}
