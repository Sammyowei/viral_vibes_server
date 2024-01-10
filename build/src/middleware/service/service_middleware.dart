// Copyright 2023, the Hawkit Pro project authors.
// Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:dart_frog/dart_frog.dart';

import '../../services/service_provider.dart';

/// Constructs and returns a middleware for service provider initialization.
/// This middleware asynchronously initializes a ServiceProvider instance
/// and provides it for middleware use.
Middleware serviceMiddleWare() {
  return provider<Future<ServiceProvider>>(
    (context) async {
      final service = ServiceProvider(); // Create a ServiceProvider instance.
      await service.initialize(); // Asynchronously initialize the service.
      return service; // Return the initialized service for middleware use.
    },
  );
}
