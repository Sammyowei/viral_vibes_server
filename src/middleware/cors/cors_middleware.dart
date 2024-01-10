// Copyright 2023, the Hawkit Pro project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars

import 'package:dart_frog/dart_frog.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart' as shelf;

/// Constructs and returns a CORS (Cross-Origin Resource Sharing) middleware.
/// This middleware adds necessary CORS headers to allow cross-origin requests.
/// It sets permissive settings allowing all origins and common HTTP methods.
Middleware corsMiddleware() {
  return fromShelfMiddleware(
    shelf.corsHeaders(
      headers: {
        shelf.ACCESS_CONTROL_ALLOW_ORIGIN:
            '*', // Allow requests from any origin.
        shelf.ACCESS_CONTROL_ALLOW_METHODS:
            'GET,PUT,PATCH,POST,DELETE', // Allow common HTTP methods.
        shelf.ACCESS_CONTROL_ALLOW_HEADERS:
            'Origin, X-Requested-With, Content-Type, Accept', // Allow specified headers.
      },
    ),
  );
}
