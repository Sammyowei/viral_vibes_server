import 'package:dart_frog/dart_frog.dart';

import '../../jwt/jwt_client.dart';

Middleware jwtMiddleware() {
  return provider(
    (context) {
      final jwtConfig = JwtClient();
      return jwtConfig;
    },
  );
}
