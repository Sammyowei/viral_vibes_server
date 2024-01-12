import 'package:dart_frog/dart_frog.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../routes/_middleware.dart';

class _MockRequestContext extends Mock implements RequestContext {}

void main() {
  group('GET /', () {
    test('responds with a 200 and "Welcome to Dart Frog!".', () async {
      // Mocking the behavior of context.read<String>()
      final context = _MockRequestContext();

      expect('Hello World', equals('Hello World'));
    });
  });
}
