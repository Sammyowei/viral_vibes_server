import 'mailer.dart';

class SmptServer extends Mailer {
  @override
  set smptEmail(String smptEmail) {
    this.smptEmail = smptEmail;
  }

  @override
  set smptPassword(String smptPassword) {
    this.smptPassword = smptPassword;
  }
}
