// ignore_for_file: lines_longer_than_80_chars

import 'dart:async';

import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_web_socket/dart_frog_web_socket.dart';

import '../../../src/db/marketplace_db_controller.dart';

final List<WebSocketChannel> connectedClients = [];
FutureOr<Response> onRequest(RequestContext context, String id) async {
  final marketplacedb = await context.read<Future<MarketplaceDbController>>();

  await marketplacedb.openConnection();

  final result = await marketplacedb.read(id);
  await marketplacedb.closeConnection();

  if (result != null) {
    print('ticket already created');
  } else {
    await marketplacedb.openConnection();
    await marketplacedb.create({'ticketID': id});
    await marketplacedb.closeConnection();

    print('new Ticket created');
  }

  final handler = webSocketHandler(
    (channel, protocol) {
      connectedClients.add(channel);
      channel.stream.listen(
        (message) async {
          for (final client in connectedClients) {
            if (client != channel) {
              client.sink.add(message);
            }
          }
        },
        onDone: () {
          connectedClients.remove(channel);
        },
      );
      Future.delayed(
        const Duration(
          seconds: 2,
        ),
        () {
          channel.sink.add(
            'Welcome to the Viral Vibes Marketplace Live Chat Channel. Our dedicated team is currently assisting other inquiries and will be with you shortly. We appreciate your patience.',
          );
        },
      );
    },
  );
  return handler(context);
}
