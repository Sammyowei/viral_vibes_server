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
  static String smptServerPassword = _Env.smptServerPassword;

  @EnviedField(varName: 'SMPT_SERVER', obfuscate: true)
  static final String smptServer = _Env.smptServer;

  @EnviedField(varName: 'SMPT_SERVER_PORT', obfuscate: true)
  static final String smptServerPort = _Env.smptServerPort;

  @EnviedField(varName: 'SMPT_SERVER_MODE', obfuscate: true)
  static final String smptServerMode = _Env.smptServerMode;

  @EnviedField(varName: 'SUPPORT_DB_STORE', obfuscate: true)
  static final String supportDbStore = _Env.supportDbStore;

  @EnviedField(varName: 'MARKET_DB_STORE', obfuscate: true)
  static final String marketplaceDbStore = _Env.marketplaceDbStore;

  @EnviedField(varName: 'FLUTTERWAVE_SECRET_TEST', obfuscate: true)
  static final String flutterwaveSecretTest = _Env.flutterwaveSecretTest;

  @EnviedField(varName: 'FLUTTERWAVE_PUBLIC_KEY_TEST', obfuscate: true)
  static final String flutterwavePublicKeyTest = _Env.flutterwavePublicKeyTest;

  @EnviedField(varName: 'FLUTTERWAVE_ENCRYPTION_KEY_TEST', obfuscate: true)
  static final String flutterwaveEncryptionKeyTest =
      _Env.flutterwaveEncryptionKeyTest;

  @EnviedField(varName: 'FLUTTERWAVE_SECRET_LIVE', obfuscate: true)
  static final String flutterwaveSecretLive = _Env.flutterwaveSecretLive;

  @EnviedField(varName: 'FLUTTERWAVE_PUBLIC_KEY_LIVE', obfuscate: true)
  static final String flutterwavePublicKeyLive = _Env.flutterwavePublicKeyLive;

  @EnviedField(varName: 'FLUTTERWAVE_ENCRYPTION_KEY_LIVE', obfuscate: true)
  static final String flutterwaveEncryptionKeyLive =
      _Env.flutterwaveEncryptionKeyLive;
}
