// Copyright 2023, the Hawkit Pro project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

abstract class ServiceClient {
  Future<void> initialize();

  Future<Map<String, dynamic>> addOrder(
      String orderId, String link, int quantity);

  Future<Map<String, dynamic>> createOrderRefil(String orderId);

  Future<Map<String, dynamic>> createMultipleOrderRefil(List<String> orderIds);

  Future<List<Map<String, dynamic>>> orderStatus();

  Future<double> getCompanyBalance();
}

class ServiceException implements Exception {
  ServiceException(this.message);

  final String message;

  @override
  String toString() => 'HttpRequestException: $message';
}
