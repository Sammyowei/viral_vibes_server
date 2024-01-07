// Copyright 2023, the Hawkit Pro project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

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
}
