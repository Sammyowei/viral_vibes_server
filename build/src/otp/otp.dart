// ignore_for_file: one_member_abstracts

import 'totp.dart';

abstract class Otp {
  String generateOtp();
  bool verifyOtp(String otp);
}

class OtpClient extends Otp {
  OtpClient({Duration? duration})
      : _duration = duration ?? const Duration(seconds: 30);
  final Duration _duration;

  TOTP get totp => _totp();
  TOTP _totp() {
    return TOTP(
        secret: 'J22U6B3WIWRRBTAV', duration: const Duration(minutes: 10));
  }

  @override
  String generateOtp() {
    return totp.generate();
  }

  @override
  bool verifyOtp(String otp) {
    return totp.verify(otp);
  }
}
