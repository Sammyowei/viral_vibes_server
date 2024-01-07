// Copyright 2023, the Hawkit Pro project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:http/http.dart' as http;

abstract class BaseHttpClient {
  Future<http.Response> getRequest(
    String endpoint, {
    Map<String, String>? headers,
  });
  Future<http.Response> postRequest(
    String endpoint,
    dynamic data, {
    Map<String, String>? headers,
  });
  Future<http.Response> putRequest(
    String endpoint,
    dynamic data, {
    Map<String, String>? headers,
  });
  Future<http.Response> deleteRequest(
    String endpoint, {
    Map<String, String>? headers,
  });
}

class HttpRequestException implements Exception {
  HttpRequestException(this.message);
  final String message;

  @override
  String toString() => 'HttpRequestException: $message';
}

Future<http.Response> _handleRequest(
    Future<http.Response> Function() request) async {
  try {
    return await request();
  } catch (error) {
    throw HttpRequestException('Failed to perform the request: $error');
  }
}
