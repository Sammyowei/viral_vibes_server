import 'package:dart_frog/dart_frog.dart';
import 'package:viral_vibes_server/lib.dart';

import '../../../src/services/service_provider.dart';

Future<Response> onRequest(RequestContext context) async {
  final service = await context.read<Future<ServiceProvider>>();

  return Response.json(body: service.services);
}
