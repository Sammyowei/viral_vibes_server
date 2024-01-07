// Copyright 2023, the Hawkit Pro project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:envied/envied.dart';
part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'VIRAL_VIBE_DB_URL', obfuscate: true)
  static final String dbUrl =
      Platform.environment['VIRAL_VIBE_DB_URL'] ?? _Env.dbUrl;

  @EnviedField(varName: 'SERVICE_API_KEY', obfuscate: true)
  static final String serviceApiKey =
      Platform.environment['SERVICE_API_KEY'] ?? _Env.serviceApiKey;

  @EnviedField(varName: 'SERVICE_API_URL', obfuscate: true)
  static final String serviceApiUrl =
      Platform.environment['SERVICE_API_URL'] ?? _Env.serviceApiKey;

  @EnviedField(varName: 'DB_STORE', obfuscate: true)
  static final String dbStore =
      Platform.environment['DB_STORE'] ?? _Env.dbStore;

  @EnviedField(varName: 'JWT_SECRET', obfuscate: true)
  static final String jwtSecret =
      Platform.environment['JWT_SECRET'] ?? _Env.jwtSecret;

  @EnviedField(varName: 'JWT_ISSUER', obfuscate: true)
  static final String jwtIssuer =
      Platform.environment['JWT_SECRET'] ?? _Env.jwtIssuer;
}
