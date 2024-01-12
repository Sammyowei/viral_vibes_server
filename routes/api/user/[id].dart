import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

import '../../../src/db/db_controller.dart';
import '../../../src/src.dart';
import '../../../src/user/user.dart';

Future<Response> onRequest(RequestContext context, String id) async {
  final email = Uri.decodeComponent(id);

  final _db = await context.read<Future<DbController>>();

  final userController = UserController(identifier: email, controller: _db);

  final user = await userController.getUser();

  if (user == null) {
    return Response.json(
      statusCode: HttpStatus.badRequest,
      body: {
        'error': 'User not Found',
      },
    );
  }

  return Response.json(
    body: user.toJson(),
  );
}
