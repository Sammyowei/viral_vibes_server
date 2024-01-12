import '../db/db_controller.dart';
import '../models/user_model.dart';

class UserController {
  UserController({required this.identifier, required this.controller});

  final String identifier;

  final DbController controller;

  Future<User?> getUser() async {
    await controller.openConnection();
    final userData = await controller.read(identifier);
    await controller.closeConnection();

    if (userData == null) {
      return null;
    } else {
      final user = User.fromJson(userData);

      return user;
    }
  }
}
