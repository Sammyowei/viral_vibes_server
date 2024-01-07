// Copyright 2023, the Hawkit Pro project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:dart_frog/dart_frog.dart';
import 'package:viral_vibes_server/lib.dart';

import '../../db/db_controller.dart';

Middleware dbMiddleware() {
  return provider<Future<DbController>>(
    (context) async {
      final dbController = DbController(store: Env.dbStore);
      await dbController.initialize();
      return dbController;
    },
  );
}
