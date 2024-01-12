// ignore_for_file: use_string_buffers, lines_longer_than_80_chars

import 'dart:convert';
import 'package:crypto/crypto.dart';

// TOTP class encapsulates Time-based One-Time Password generation and verification
class TOTP {
  // Secret key used for OTP generation

  // Constructor to initialize TOTP with a secret key
  TOTP({
    String? secret,
    Duration? duration,
  }) {
    _secret = secret ?? 'J22U6B3WIWRRBTAV';

    _duration = duration ?? const Duration(seconds: 30);
  }
  late final String _secret;

  late Duration _duration;

  // Method to generate a 5-digit OTP based on the secret and timeStep
  String generate() {
    final timeStep = _duration.inSeconds;
    final currentUnixTime =
        (DateTime.now().millisecondsSinceEpoch ~/ 1000) ~/ timeStep;
    final counter =
        _intToBytes(currentUnixTime); // Convert current time to bytes
    final hmac = _generateHmacSHA1(counter); // Generate HMAC-SHA1 hash
    final offset = _calculateOffset(hmac); // Calculate the offset from the hash
    final otp = offset % 100000; // Generate a 5-digit OTP

    return otp
        .toString()
        .padLeft(5, '0'); // Return OTP as a string with 5 digits
  }

  // Method to verify if the provided OTP is valid within a time window
  bool verify(String otp, {int window = 1}) {
    final timeStep = _duration.inSeconds;
    final currentUnixTime =
        (DateTime.now().millisecondsSinceEpoch ~/ 1000) ~/ timeStep;

    for (var i = -window; i <= window; i++) {
      final counter =
          _intToBytes(currentUnixTime + i); // Convert time counter to bytes
      final hmac = _generateHmacSHA1(counter); // Generate HMAC-SHA1 hash
      final offset =
          _calculateOffset(hmac); // Calculate the offset from the hash
      final generatedOTP = offset % 100000; // Generate a 5-digit OTP

      // Check if the provided OTP matches the generated OTP
      if (otp == generatedOTP.toString().padLeft(5, '0')) {
        return true; // OTP is valid
      }
    }

    return false; // OTP is not valid within the window
  }

  // Method to generate an HMAC-SHA1 hash based on the secret and counter
  String _generateHmacSHA1(String counter) {
    final hmacKey = utf8.encode(_secret); // Encode secret to bytes
    final hmacData = utf8.encode(counter); // Encode counter to bytes

    final hmac = Hmac(sha1, hmacKey); // Initialize HMAC-SHA1 with secret key
    final hmacBytes = hmac.convert(hmacData).bytes; // Generate hash bytes
    return _bytesToHex(hmacBytes); // Return hash as a hexadecimal string
  }

  // Method to convert an integer value to bytes (8 bytes in total)
  String _intToBytes(int value) {
    var result = '';
    for (var i = 7; i >= 0; i--) {
      final byte = (value >> (i * 8)) & 0xff; // Extract individual bytes
      result += String.fromCharCode(byte); // Append bytes to the result
    }
    return result; // Return the byte representation
  }

  // Method to calculate the offset from the last bytes of the hash
  int _calculateOffset(String hmac) {
    var offset = int.parse(hmac.substring(hmac.length - 1),
        radix: 16); // Get the last byte as an integer
    offset &= 0xf; // Apply bitwise operation to ensure positive value

    final binary = int.parse(
      hmac.substring(offset * 2, (offset * 2) + 8),
      radix: 16,
    ); // Get 4 bytes from the hash
    return binary & 0x7fffffff; // Return a positive integer as offset
  }

  // Method to convert a list of bytes to a hexadecimal string
  String _bytesToHex(List<int> bytes) {
    return bytes.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join();
  }
}
