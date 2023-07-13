import '../resources/strings.dart';

const patternEmail = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

const patternName = r"^([ \u00c0-\u02ffa-zA-Z'\-])+$";


String? validatePassword(String? value) {
  if (value != null) {
    if (value.length < 6 && value.isNotEmpty) {
      return Strings.passwordRequired;
    }
    if (value.isEmpty) {
      return Strings.passwordRequired;
    }
  }
  return null;
}

String? validateEmail(String? value) {
  if (value != null) {
    if (!RegExp(patternEmail).hasMatch(value)) {
      return Strings.invalidEmail;
    }
  }
  return null;
}
