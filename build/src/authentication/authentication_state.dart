abstract class AuthenticationDataState {}

class LoginAuthenticationStateData extends AuthenticationDataState {
  LoginAuthenticationStateData({
    this.email,
    this.password,
  });

  factory LoginAuthenticationStateData.fromJson(Map<String, dynamic> json) {
    return LoginAuthenticationStateData(
      email: json['email'] as String?,
      password: json['password'] as String?,
    );
  }
  String? email;
  String? password;
  late Map<String, String> _response;

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

  bool isEmailValid() {
    final emailRegExp =
        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$', caseSensitive: false);
    return emailRegExp.hasMatch(email!);
  }
}
