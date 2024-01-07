// ignore_for_file: lines_longer_than_80_chars

import 'authentication_state.dart';

class SignUpAuthenticationStateData extends AuthenticationDataState {
  SignUpAuthenticationStateData({
    this.userName,
    this.password,
    this.email,
    this.mobileNumber,
  });

  factory SignUpAuthenticationStateData.fromJson(Map<String, dynamic> json) {
    return SignUpAuthenticationStateData(
      userName: json['userName'] as String?,
      password: json['password'] as String?,
      email: json['email'] as String?,
      mobileNumber: json['mobileNumber'] as String?,
    );
  }
  String? userName;
  String? password;
  String? email;
  String? mobileNumber;

  late Map<String, String> _response;

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

  bool isEmailValid() {
    final emailRegExp =
        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$', caseSensitive: false);
    return emailRegExp.hasMatch(email!);
  }
}
