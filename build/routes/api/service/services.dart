// Copyright 2023, the Hawkit Pro project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Import necessary Dart libraries and packages.
import 'package:dart_frog/dart_frog.dart';

// Import the service provider.
import '../../../src/services/service_provider.dart';

// Define an asynchronous function to handle incoming requests.
Future<Response> onRequest(RequestContext context) async {
  // Retrieve the service provider.
  final service = await context.read<Future<ServiceProvider>>();

  // Return a JSON response containing the services provided.
  return Response.json(body: service.services);
}
