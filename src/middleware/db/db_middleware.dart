// Copyright 2023, the Hawkit Pro project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:dart_frog/dart_frog.dart';
import 'package:viral_vibes_server/lib.dart';

import '../../db/db_controller.dart';
import '../../db/marketplace_db_controller.dart';
import '../../db/support_db_controller.dart';

/// Constructs and returns a middleware for database connection.
/// This middleware initializes and provides access to a database controller.
Middleware dbMiddleware() {
  return provider<Future<DbController>>(
    (context) async {
      final dbController = DbController(store: Env.dbStore);
      await dbController.initialize();
      return dbController;
    },
  );
}

Middleware supportDbMiddleware() {
  return provider<Future<SupportDbController>>((context) async {
    final supportDbController = SupportDbController(store: Env.supportDbStore);
    await supportDbController.initialize();

    return supportDbController;
  });
}

Middleware marketPlaceDbMiddleware() {
  return provider<Future<MarketplaceDbController>>((context) async {
    final marketPlaceBDController =
        MarketplaceDbController(store: Env.marketplaceDbStore);

    await marketPlaceBDController.initialize();

    return marketPlaceBDController;
  });
}
