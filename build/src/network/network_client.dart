// Copyright 2023, the Hawkit Pro project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/src/response.dart';

import 'base_client.dart';

class NetworkHttpClient implements BaseHttpClient {
  NetworkHttpClient({required this.baseUrl});

  final String baseUrl;

  Future<http.Response> _handleRequest(
    Future<http.Response> Function() request,
  ) async {
    try {
      return request();
    } catch (error) {
      throw HttpRequestException('Failed to perform the request: $error');
    }
  }

  @override
  Future<Response> deleteRequest(
    String endpoint, {
    Map<String, String>? headers,
  }) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    return _handleRequest(() async {
      return http.delete(url, headers: headers);
    });
  }

  @override
  Future<Response> getRequest(
    String endpoint, {
    Map<String, String>? headers,
  }) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    return _handleRequest(() async {
      return http.get(url, headers: headers);
    });
  }

  @override
  Future<Response> postRequest(
    String endpoint,
    dynamic data, {
    Map<String, String>? headers,
  }) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    return _handleRequest(() async {
      return http.post(url, body: data, headers: headers);
    });
  }

  @override
  Future<Response> putRequest(
    String endpoint,
    dynamic data, {
    Map<String, String>? headers,
  }) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    return _handleRequest(() async {
      return http.put(url, body: data, headers: headers);
    });
  }
}
