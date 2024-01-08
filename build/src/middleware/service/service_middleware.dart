import 'package:dart_frog/dart_frog.dart';

import '../../services/service_provider.dart';

Middleware serviceMiddleWare() {
  return provider<Future<ServiceProvider>>(
    (context) async {
      final service = ServiceProvider();
      await service.initialize();
      return service;
    },
  );
}
