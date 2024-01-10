// Copyright 2023, the Hawkit Pro project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'authentication_state.dart';

/// Represents the state data for login authentication.
class LoginAuthenticationStateData extends AuthenticationDataState {
  /// Constructs a LoginAuthenticationStateData object from JSON.
  factory LoginAuthenticationStateData.fromJson(Map<String, dynamic> json) {
    return LoginAuthenticationStateData(
      email: json['email'] as String?,
      password: json['password'] as String?,
    );
  }

  /// Email for login authentication.
  String? email;

  /// Password for login authentication.
  String? password;

  late Map<String, String> _response;

  /// Constructs a LoginAuthenticationStateData object.
  LoginAuthenticationStateData({
    this.email,
    this.password,
  });

  /// Checks for null values in login data.
  ///
  /// Returns a map with keys representing required fields and their corresponding status.
  Map<String, String> checkForNullValue() {
    if (email == null || password == null) {
      _response = {
        'email': 'Required',
        'password': 'Required',
      };

      if (email != null) {
        _response.remove('email');
      }

      if (password != null) {
        _response.remove('password');
      }

      return _response;
    } else {
      return {
        'message': 'Proceed',
      };
    }
  }

  /// Validates the email format.
  ///
  /// Returns true if the email is valid, false otherwise.
  bool isEmailValid() {
    final emailRegExp =
        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$', caseSensitive: false);
    return emailRegExp.hasMatch(email!);
  }
}
