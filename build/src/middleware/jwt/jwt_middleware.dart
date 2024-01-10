// Copyright 2023, the Hawkit Pro project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:dart_frog/dart_frog.dart';

import '../../jwt/jwt_client.dart';

/// Constructs and returns a middleware for JWT (JSON Web Token) configuration.
/// This middleware provides a JWT client instance for token handling.
Middleware jwtMiddleware() {
  return provider(
    (context) {
      final jwtClient = JwtClient(); // Create a JWT client instance.
      return jwtClient; // Return the JWT client for middleware use.
    },
  );
}
