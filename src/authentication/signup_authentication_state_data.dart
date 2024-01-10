// Copyright 2023, the Hawkit Pro project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: lines_longer_than_80_chars

import 'authentication_state.dart';

/// Represents the state data for sign-up authentication.
class SignUpAuthenticationStateData extends AuthenticationDataState {
  /// Constructs a SignUpAuthenticationStateData object.
  SignUpAuthenticationStateData({
    this.userName,
    this.password,
    this.email,
    this.mobileNumber,
  });

  /// Constructs a SignUpAuthenticationStateData object from JSON.
  factory SignUpAuthenticationStateData.fromJson(Map<String, dynamic> json) {
    return SignUpAuthenticationStateData(
      userName: json['userName'] as String?,
      password: json['password'] as String?,
      email: json['email'] as String?,
      mobileNumber: json['mobileNumber'] as String?,
    );
  }

  /// Username for sign-up.
  String? userName;

  /// Password for sign-up.
  String? password;

  /// Email for sign-up.
  String? email;

  /// Mobile number for sign-up.
  String? mobileNumber;

  late Map<String, String> _response;

  /// Checks for null values in sign-up data.
  ///
  /// Returns a map with keys representing required fields and their corresponding status.
  Map<String, String> checkForNullValue() {
    if (email == null ||
        password == null ||
        userName == null ||
        mobileNumber == null) {
      _response = {
        'email': 'Required',
        'password': 'Required',
        'userName': 'Required',
        'mobileNumber': 'Required',
      };

      if (email != null) {
        _response.remove('email');
      }

      if (password != null) {
        _response.remove('password');
      }

      if (userName != null) {
        _response.remove('userName');
      }

      if (mobileNumber != null) {
        _response.remove('mobileNumber');
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
