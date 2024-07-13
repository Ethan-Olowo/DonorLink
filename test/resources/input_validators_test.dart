import 'package:donorlink/resources/input_validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('hasSpecialCharacters', () {
    test('return true', () {
      expect(hasSpecialCharacters('\$pec!alCh@racters'), true);
    });
    test('return false', () {
      expect(hasSpecialCharacters('noSpecialCharacters'), false);
    });
  });
  
  group('Email Validator', () {
    test('returns error when email is null', () {
      expect(emailValidator(null), 'Please enter an email');
    });

    test('returns error when email is empty', () {
      expect(emailValidator(''), 'Please enter an email');
    });

    test('returns error when email is invalid', () {
      expect(emailValidator('invalid'), 'Please enter a valid email');
    });

    test('returns null when email is valid', () {
      expect(emailValidator('valid@example.com'), null);
    });
  });

  group('Password Validator', () {
    test('returns error when password is null', () {
      expect(passwordValidator(null), 'Please enter a password');
    });

    test('returns error when password is empty', () {
      expect(passwordValidator(''), 'Please enter a password');
    });

    test('returns error when password is too short', () {
      expect(passwordValidator('short'),
          'Please enter password longer than 8 characters');
    });

    test('returns error when password has no special characters', () {
      expect(passwordValidator('nopassword'),
          'Please enter password with at least one special character');
    });

    test('returns null when password is valid', () {
      expect(passwordValidator('ValidPassword\$1'), null);
    });
  });

  group('Confirm Password Validator', () {
    test('returns error when confirm password is null', () {
      expect(confirmPasswordValidator(null, 'password'),
          'Please enter a password');
    });

    test('returns error when confirm password is empty', () {
      expect(
          confirmPasswordValidator('', 'password'), 'Please enter a password');
    });

    test('returns error when confirm password does not match', () {
      expect(confirmPasswordValidator('different', 'password'),
          'Password does not match');
    });

    test('returns null when confirm password matches', () {
      expect(confirmPasswordValidator('password', 'password'), null);
    });
  });

  group('Phone Validator', () {
    test('Empty input returns error', () {
      expect(phoneValidator(null), 'Please enter a phone number');
      expect(phoneValidator(''), 'Please enter a phone number');
    });

    test('Input with less than 10 characters returns error', () {
      expect(phoneValidator('123456'), 'Please enter a valid phone number');
    });

    test('Input without numbers returns error', () {
      expect(phoneValidator('abcdefg'), 'Please enter a valid phone number');
    });

    test('Valid phone number returns null', () {
      expect(phoneValidator('1234567890'), null);
      expect(phoneValidator('+0123456789'), null);
    });

    test('Input with non-numeric characters returns error', () {
      expect(phoneValidator('123456789a'), 'Please enter a valid phone number');
    });
  });
}
