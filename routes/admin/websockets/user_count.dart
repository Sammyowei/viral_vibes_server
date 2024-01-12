import 'dart:async';
import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_web_socket/dart_frog_web_socket.dart';

import '../../../src/db/db_controller.dart';

Future<Response> onRequest(RequestContext context) async {
  var connectedUsers = 0;
  Timer? timer;

  final handler = webSocketHandler(
    (channel, protocol) {
      connectedUsers++;

      // Start the timer only when the first user connects
      if (connectedUsers == 1) {
        timer = Timer.periodic(
          const Duration(seconds: 30),
          (timer) async {
            final db = await context.read<Future<DbController>>();
            final users = await db.queryAll();

            final data = {'userCount': users.length};
            final encodedData = jsonEncode(data);
            // Always send data, even if no one is connected
            channel.sink.add(encodedData);
          },
        );
      }

      channel.stream.listen(
        (message) {
          // Handle incoming messages if needed

          print(message);
        },
        onDone: () {
          // User disconnected
          connectedUsers--;
          print('user disconected');
          // Stop the timer when no one is connected
          if (connectedUsers == 0 && timer != null && timer!.isActive) {
            timer?.cancel();
          }
        },
      );
    },
  );

  return handler(context);
}
