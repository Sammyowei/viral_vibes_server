// Copyright 2023, the Hawkit Pro project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: lines_longer_than_80_chars, comment_references

import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import '../db/db_controller.dart';
import '../jwt/jwt_client.dart';
import '../models/user_model.dart';
import 'authentication.dart';

class AuthenticationController extends Authentication {
  AuthenticationController({
    required this.dbController,
    required this.emailAddress,
    this.userName = '',
    this.password = '',
    this.jwtToken = '',
    this.mobileNumber = '',
  });
  late Map<String, dynamic> _response;

  final DbController dbController;
  late User _user;

  Map<String, dynamic> get response => _response;

  final String emailAddress;
  final String userName;
  final String password;
  final String mobileNumber;
  final String jwtToken;

  /// Allows you to validate the current User session by verifying the [jwtToken]
  /// to check if the user session is still active or  expired or has an error.
  @override
  bool activeSession() {
    final jwtClient = JwtClient();
    final isActive = jwtClient.verifyJwt(jwtToken);
    return isActive;
  }

  /// Allows you to validate if a current user exist using the [DbController] client to read and get this user data
  /// and parse it to  the [User] model using the [User.fromJson] factory constructor in the [User] model.
  /// If the [data] in the from the db is null? then return [errorResponse], But if its availiable it should Uses the void setter in the [User] model
  /// to change the value of the pasword after it has been encrypted with the salt value from the current [User] instance [_user]
  /// and opening connection to the [DbController] and use the [dbController] instance of [DbController] to update that particular document with those values using the
  /// [emailAddress] as an identifier.
  @override
  Future<Map<String, dynamic>> resetPassword(String newPassword) async {
    final errorResponse = {
      'error': 'Yo are not authorised to perform this action.'
    };

    final successMessage = {
      'message': 'Password Changed Sucessfully',
    };
    final payloadFromUser = await dbController.read(emailAddress);

    if (payloadFromUser == null) {
      return errorResponse;
    } else {
      _user = User.fromJson(payloadFromUser);

      final salt = _user.passwordSalt;
      final newHashedPassword = hashPassword(password: password, salt: salt);
      _user.updatePassword(newHashedPassword);

      final newUserDetail = User.fromJson(_user.toJson());
      await dbController.openConnection();
      await dbController.update(emailAddress, newUserDetail.toJson());
      await dbController.closeConnection();
      return successMessage;
    }
  }

  /// This is the [AuthenticationController] function for allowing you to validating a [user] by checking if the [User] exist.
  /// If the [User] Exist then it and the [data] gotten from featching the [user] details from the [DbController].
  /// next step Validates if the [user]  password is correct  by gettiing the [password] from the constructor and the [_user.passwordSalt]
  /// to create a hashed  reference that would be used to validate the  checked password to see if it matches the [_user.password] instance from the [User] model
  /// and return response accordingly.

  @override
  Future<Map<String, dynamic>> signIn() async {
    await dbController.openConnection();
    final data = await dbController.read(emailAddress);
    await dbController.closeConnection();

    /// Data Validation to see if the user with the [emailAddress] exist.

    if (data == null) {
      return {
        'error':
            'The email provided does not match any existing account in our records.',
      };
    } else {
      _user = User.fromJson(data);

      // Data Validation for password Check

      final hashedPassword =
          hashPassword(password: password, salt: _user.passwordSalt);

      if (hashedPassword != _user.password) {
        return {'error': 'The password entered is incorrect'};
      }
      final responseDetail = _user.toJson();
      return {
        'message': 'Login successful.',
        'detail': responseDetail,
      };
    }
  }

  /// Allows you to register and save user data from the [_user] instance to the db Using the [dbController.create] function.
  /// Firstly, it checks if the user exist by first trying to read the user data from the Database by using the [emailAddress] as an identifier
  /// and return an error response if a user with that  data exist, but if it returns null it should then parse abd save the [JSON] value of the [_user]
  /// instance and create a new document in the [DB] provider and save this value in it.
  @override
  Future<Map<String, dynamic>> signUp() async {
    await dbController.openConnection();

    final dataPayload = await dbController.read(emailAddress);
    await dbController.closeConnection();

    if (dataPayload != null) {
      return {'error': 'An account with this email address already exists.'};
    } else {
      final passwordSalt = passwordSaltGenerator();
      final hashedPassword =
          hashPassword(password: password, salt: passwordSalt);
      _user = User(
        userName: userName,
        emailAddress: emailAddress,
        mobileNumber: mobileNumber,
        password: hashedPassword,
        passwordSalt: passwordSalt,
      );

      await dbController.openConnection();
      await dbController.create(_user.toJson());
      await dbController.closeConnection();

      return {
        'message': 'Account Created Sucessfully',
        'detail': _user.toJson(),
      };
    }
  }

  /// Allows you to generate a unique [salt] that would be used in encrypting the [password].

  @override
  String passwordSaltGenerator() {
    final random = Random.secure();
    final bytes = List<int>.generate(32, (_) => random.nextInt(256));
    return base64Url.encode(bytes);
  }

  /// Generates a Unique  [hashedPassword] by encypting it using the [Hmac] [sha256] hashing algorithm.
  /// This is made as a safety precaution in case of data breach to protect all userData. by encrypting it.

  @override
  String hashPassword({
    required String password,
    required String salt,
  }) {
    final saltedPassword = '$salt$password';
    final hashedPassword =
        sha256.convert(utf8.encode(saltedPassword)).toString();
    return hashedPassword;
  }
}
