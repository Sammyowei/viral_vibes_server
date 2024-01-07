// Copyright 2023, the Hawkit Pro project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: lines_longer_than_80_chars, comment_references

import 'package:mongo_dart/mongo_dart.dart' as mongod;
import 'package:viral_vibes_server/lib.dart';

import '_db.dart';

/// Allows and implement all CRUD operation from the [Db] class.
///
/// A facade of `package:mongo_dart`.
class DbController extends Db {
  DbController({required this.store});
  late mongod.Db _db;

  bool get isInitialized => _isIntialized;

  bool _isIntialized = false;
  final String store;

  /// Allows You to Create a Connection to the db cluster using the [Db] initialize function
  @override
  Future<void> initialize() async {
    if (!_isIntialized) {
      _db = await mongod.Db.create('${Env.dbUrl}viralvibes');
      _isIntialized = true;
    } else {
      _db = await mongod.Db.create('${Env.dbUrl}viralvibes');
    }
  }

  /// Closes Connection by checking if the [_db.isConnected]  status is `true` then close the connecttion
  @override
  Future<void> closeConnection() async {
    if (_db.isConnected == true) {
      await _db.close();
    }
  }

  /// Opens Connection  by chacking if the [_db.isConnected] status is `false` then open connection to the [Db]
  /// to perform all [CRUD] connections.
  @override
  Future<void> openConnection() async {
    if (_db.isConnected == false) {
      await _db.open();
    }
  }

  /// Create a document in the [store] db collection with in inserts the [data] into the created Document
  @override
  Future<void> create(Map<String, dynamic> data) async {
    await _db.collection(store).insertOne(data);
  }

  /// Delete's a document from the  [store] db collection by using the parameter [identifier] which  checks for the field [emailAddress]
  /// and deletes the document with all its data stored in it.
  @override
  Future<void> delete(String identifier) async {
    final query = mongod.where.eq('emailAddress', identifier);
    await _db.collection(store).remove(query);
  }

  /// reads all the data from a particular document in the [store] collection by using the [identifier] as a selector to get a document where the field
  /// [emailAddress] has a value of the [identifier] to query the document.
  @override
  Future<Map<String, dynamic>?> read(String identifier) async {
    final query = mongod.where.eq('emailAddress', identifier);

    final data = await _db.collection(store).findOne(query);
    return data;
  }

  /// Udate old stored data in a document in the [store] collection by using the  [identifier] as a selector to query the particular document
  /// where the field [emailAddress] has a value of the [identifier] and modifying it using the [store.replaceOne] function from [MongoDb]
  @override
  Future<void> update(String identifier, Map<String, dynamic> data) async {
    final query = mongod.where.eq('emailAddress', identifier);
    await _db.collection(store).replaceOne(query, data);
  }
}
