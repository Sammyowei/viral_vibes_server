// ignore_for_file: lines_longer_than_80_chars

import 'dart:async';

import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_web_socket/dart_frog_web_socket.dart';

import '../../../src/db/support_db_controller.dart';

final List<WebSocketChannel> connectedClients = [];
FutureOr<Response> onRequest(RequestContext context, String id) async {
  final supportDb = await context.read<Future<SupportDbController>>();

  await supportDb.openConnection();

  final result = await supportDb.read(id);
  await supportDb.closeConnection();

  if (result != null) {
    print('ticket already created ');
  } else {
    await supportDb.openConnection();
    await supportDb.create({'ticketID': id});
    await supportDb.closeConnection();

    print('new Ticket created');
  }

  final handler = webSocketHandler(
    (channel, protocol) {
      connectedClients.add(channel);
      channel.stream.listen(
        (message) async {
          // Listen to the incomming json encoded message and perfom the message adding abd parse it to the db

          for (var client in connectedClients) {
            if (client != channel) {
              client.sink.add(message);
            }
          }

          print("Message received from $id: $message");
        },
        onDone: () {
          // What to do when they disconnect fro the websocket
          connectedClients.remove(channel);
        },
      );
      Future.delayed(
        const Duration(
          seconds: 2,
        ),
        () {
          channel.sink.add(
            'Welcome to the Viral Vibes Support Live Chat Channel. Our dedicated customer representatives are currently attending to other inquiries and will be with you shortly. We appreciate your patience.',
          );
        },
      );
    },
  );
  return handler(context);
}
