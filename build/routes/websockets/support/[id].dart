// ignore_for_file: lines_longer_than_80_chars

import 'dart:async';
import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_web_socket/dart_frog_web_socket.dart';

import '../../../src/db/support_db_controller.dart';
import '../../../src/models/message_model.dart';
import '../../../src/models/support_data_model.dart';

FutureOr<Response> onRequest(RequestContext context, String id) async {
  final supportDbController = await context.read<Future<SupportDbController>>();

  await supportDbController.openConnection();

  final ticket = await supportDbController.read(id);
  await supportDbController.closeConnection();

  late SupportChatModel chats;
  if (ticket == null) {
    chats = SupportChatModel(ticketID: id);
    await supportDbController.openConnection();
    await supportDbController.create(chats.toJson());
    await supportDbController.closeConnection();
  } else {
    chats = SupportChatModel.fromJson(ticket);
  }

  final handler = webSocketHandler(
    (channel, protocol) {
      channel.stream.listen(
        (message) async {
          // Listen to the incomming json encoded message and perfom the message adding abd parse it to the db

          final serializedMessage = jsonDecode(message as String);
          // print(serializedMessage);
          final messageModel =
              MessageModel.fromJson(serializedMessage as Map<String, dynamic>);

          print(messageModel.id);
          print(messageModel.message);

          chats.addTomessages(messageModel);

          await supportDbController.openConnection();
          await supportDbController.update(chats.ticketID, chats.toJson());
          await supportDbController.closeConnection();
          channel.sink.add(
            jsonEncode(
              chats.toJson(),
            ),
          );
        },
        onDone: () {
          // What to do when they disconnect fro the websocket
        },
      );

//
      final serializedResponse = jsonEncode(chats.toJson());
      channel.sink.add(serializedResponse);
    },
  );
  return handler(context);
}
