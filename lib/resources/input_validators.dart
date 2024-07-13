
String? emailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter an email';
  } else if (!value.contains('@')) {
    return 'Please enter a valid email';
  }
  return null;
}

String? nullValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'This field is required';
  }
  return null;
}

String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a password';
  } else if (value.length < 8) {
    return 'Please enter password longer than 8 characters';
  } else if (!hasSpecialCharacters(value)) {
    return 'Please enter password with at least one special character';
  } else if (!hasNumber(value)) {
    return 'Please enter password with at least one number';
  }
  return null;
}

String? confirmPasswordValidator(String? value, String? password) {
  if (value == null || value.isEmpty) {
    return 'Please enter a password';
  } else if (value != password) {
    return 'Password does not match';
  }
  return null;
}

bool hasNumber(String value) {
  return value.contains(RegExp(r'\d'));
}

bool hasSpecialCharacters(String value) {
  final regexp = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
  return regexp.hasMatch(value);
}

String? phoneValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a phone number';
  } else if (value.length < 10) {
    return 'Please enter a valid phone number';
  } else if (!RegExp(r'^[+0-9]+$').hasMatch(value)) {
    return 'Please enter a valid phone number';
  }
  return null;
}

String? numberValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a number';
  } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
    return 'Please enter a number number';
  }
  return null;
}
