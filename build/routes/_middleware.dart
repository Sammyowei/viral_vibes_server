// Copyright 2023, the Hawkit Pro project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: lines_longer_than_80_chars

import 'package:dart_frog/dart_frog.dart';

import '../src/src.dart';

/// Creates a middleware chain by composing various middleware functions.
/// This middleware chain includes CORS, JWT authentication, database, and service middlewares.
Handler middleware(Handler handler) {
  return handler
      .use(corsMiddleware()) // Apply CORS middleware.
      .use(jwtMiddleware()) // Apply JWT authentication middleware.
      .use(dbMiddleware()) // Apply database middleware.
      .use(serviceMiddleWare()) // Apply service middleware.
      .use(otpMiddleWare())
      .use(supportDbMiddleware())
      .use(marketPlaceDbMiddleware()); // Apply Otp middleware
}
