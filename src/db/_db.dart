// Copyright 2023, the Hawkit Pro project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

//  An Abstarct class [Db] that performs all CRUD Operations.

abstract class Db {
//
  /// This implement an initialization function that initialises the DB
  /// provider.
  Future<void> initialize();
  Future<void> openConnection();
  Future<void> closeConnection();
  Future<void> create(Map<String, dynamic> data);
  Future<Map<String, dynamic>?> read(String identifier);
  Future<void> update(String identifier, Map<String, dynamic> data);
  Future<void> delete(String identifier);
}
