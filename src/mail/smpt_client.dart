import 'mailer.dart';

class SmptClient extends Mailer {
  late String _smptEmail;
  late String _smptPassword;

  @override
  set smptEmail(String smptEmail) {
    _smptEmail = smptEmail;
  }

  @override
  set smptPassword(String smptPassword) {
    _smptPassword = smptPassword;
  }

  String get smptEmail {
    return _smptEmail;
  }

  String get smptPassword {
    return _smptPassword;
  }
}
