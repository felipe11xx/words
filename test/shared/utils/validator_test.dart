
import 'package:flutter_test/flutter_test.dart';
import 'package:words/shared/resources/resources.dart';
import 'package:words/shared/utils/utils.dart';

void main() {
  group('validatePassword', () {
    test('returns the correct error message when the password is too short', () {
      const password = 'abc';

      final result = validatePassword(password);

      expect(result, Strings.passwordRequired);
    });

    test('returns null when the password has a valid length', () {
      const password = 'password123';

      final result = validatePassword(password);

      expect(result, null);
    });

    test('returns null when the password is empty', () {
      const password = '';

      final result = validatePassword(password);

      expect(result, Strings.passwordRequired);
    });
  });

  group('validateEmail', () {
    test('returns the correct error message when the email is invalid', () {
      const email = 'invalid_email';

      final result = validateEmail(email);

      expect(result, Strings.invalidEmail);
    });

    test('returns null when the email is valid', () {
      const email = 'test@example.com';

      final result = validateEmail(email);

      expect(result, null);
    });

    test('returns null when the email is empty', () {
      const email = '';

      final result = validateEmail(email);

      expect(result, Strings.invalidEmail);
    });
  });
}
