import 'package:dart_frog/dart_frog.dart';

import '../src/src.dart';

Handler middleware(Handler handler) {
  return handler
      .use(corsMiddlerware())
      .use(jwtMiddleware())
      .use(dbMiddleware());
}
