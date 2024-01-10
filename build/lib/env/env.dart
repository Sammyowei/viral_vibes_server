// Copyright 2023, the Hawkit Pro project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:io';

import 'package:envied/envied.dart';
part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'VIRAL_VIBE_DB_URL', obfuscate: true)
  static final String dbUrl = _Env.dbUrl;

  @EnviedField(varName: 'SERVICE_API_KEY', obfuscate: true)
  static final String serviceApiKey = _Env.serviceApiKey;

  @EnviedField(varName: 'SERVICE_API_URL', obfuscate: true)
  static final String serviceApiUrl = _Env.serviceApiUrl;

  @EnviedField(varName: 'DB_STORE', obfuscate: true)
  static final String dbStore = _Env.dbStore;

  @EnviedField(varName: 'JWT_SECRET', obfuscate: true)
  static final String jwtSecret = _Env.jwtSecret;

  @EnviedField(varName: 'JWT_ISSUER', obfuscate: true)
  static final String jwtIssuer = _Env.jwtIssuer;

  @EnviedField(varName: 'SMPT_SERVER_EMAIL', obfuscate: true)
  static final String smptServerEmail = _Env.smptServerEmail;

  @EnviedField(varName: 'SMPT_SERVER_PASSWORD', obfuscate: true)
  static final String smptServerPassword = _Env.smptServerPassword;

  @EnviedField(varName: 'SMPT_SERVER', obfuscate: true)
  static final String smptServer = _Env.smptServer;

  @EnviedField(varName: 'SMPT_SERVER_PORT', obfuscate: true)
  static final String smptServerPort = _Env.smptServerPort;

  @EnviedField(varName: 'SMPT_SERVER_MODE', obfuscate: true)
  static final String smptServerMode = _Env.smptServerMode;
}


// class Env {
//   static final String dbUrl = Platform.environment['VIRAL_VIBE_DB_URL']!;
//   static final String serviceApiKey = Platform.environment['SERVICE_API_KEY']!;
//   static final String serviceApiUrl = Platform.environment['SERVICE_API_KEY']!;
//   static final String dbStore = Platform.environment['DB_STORE']!;
//   static final String jwtIssuer = Platform.environment['JWT_SECRET']!;
//   static final String jwtSecret = Platform.environment['JWT_SECRET']!;
// }
