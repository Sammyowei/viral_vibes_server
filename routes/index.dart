import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context) {
  final request = context.request;
  final port = request.connectionInfo.remoteAddress.rawAddress;
  return Response(
    body: 'Viral vibe endpoint @ api.viralvibe.hawkitpro.com : $port',
  );
}
