// Copyright 2023, the Hawkit Pro project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: sort_constructors_first

class OrderModel {
  OrderModel({required this.id, required this.link, DateTime? createdAt})
      : this.createdAt = createdAt ?? DateTime.now();

  final int id;
  final String link;
  final DateTime createdAt;

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
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
