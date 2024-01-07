// Copyright 2023, the Hawkit Pro project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: comment_references, lines_longer_than_80_chars

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart' as jw;
import 'package:viral_vibes_server/lib.dart';

import 'jwt.dart';

/// [JwtClient] that extends the methods of the abstract class [Jwt].
class JwtClient extends Jwt {
  /// Allows you to sign and return a [signedJwtToken] using a [payload] passed as a pasrameter
  /// Note: The [payload] is required as [Map<String, dynamic>{}]

  @override
  String signJwt({required Map<String, dynamic> payload}) {
    final jwt = jw.JWT(payload, issuer: Env.jwtIssuer);

    /// Sign and generates the `jwtToken`.
    final signedJwtToken = jwt.sign(
      jw.SecretKey(Env.jwtSecret),
      expiresIn: const Duration(
        days: 14,
        hours: 12,
      ),
    );
    return signedJwtToken;
  }

  /// Allows you to verify signed Json Web Token [jwtToken] and validate if it is signed
  /// or it is invalid or expired.
  @override
  bool verifyJwt(String jwtToken) {
    try {
      final jwt = jw.JWT.verify(
        jwtToken,
        jw.SecretKey(Env.jwtSecret),
      );
      return true;
    } on jw.JWTExpiredException catch (err) {
      return false;
    } on jw.JWTException catch (err) {
      return false;
    }
  }
}
