import 'package:dart_frog/dart_frog.dart';

import '../../otp/otp.dart';

Middleware otpMiddleWare() {
  return provider(
    (context) {
      return OtpClient(
        duration: const Duration(minutes: 10),
      );
    },
  );
}
