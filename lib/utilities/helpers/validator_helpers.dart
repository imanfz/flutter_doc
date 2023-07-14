/// Function to validate email is in the correct format
bool isValidEmail(String email) {
  return RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}

/// Function to validate password in the correct format
bool isValidPassword(String password) {
  return RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
      .hasMatch(password);
}

/// Function to validate text field
bool isValidField(String field) {
  if (field.isNotEmpty) {
    return true;
  } else {
    return false;
  }
}

bool isStringMatch(String first, String second) {
  return first == second;
}

/// Function to check if string contain lowercase
bool isContainLowercase(String text) {
  return text.contains(RegExp(r'[a-z]'));
}

/// Function to check if string contain uppercase
bool isContainUppercase(String text) {
  return text.contains(RegExp(r'[A-Z]'));
}

/// Function to check if string contain number
bool isContainNumber(String text) {
  return text.contains(RegExp(r'[0-9]'));
}

/// Function to check if string contain symbol
bool isContainSymbol(String text) {
  return text.contains(RegExp(r'[\^$*.\[\]{}()?\-"!@#%&/\,><:;_~`+=]'));
}

/// Function to check if string contain sequential digits
bool isContainSequentialDigits(String input) {
  for (int i = 0; i < input.length - 2; i++) {
    int currentDigit = int.parse(input[i]);
    int nextDigit = int.parse(input[i + 1]);
    int thirdDigit = int.parse(input[i + 2]);

    if (currentDigit + 1 == nextDigit && nextDigit + 1 == thirdDigit) {
      return true;
    }
  }

  return false;
}

/// Function to check if string contain alphabets
bool isContainSequentialAlphabets(String input) {
  for (int i = 0; i < input.length - 2; i++) {
    String currentChar = input[i];
    String nextChar = String.fromCharCode(input.codeUnitAt(i + 1));
    String thirdChar = String.fromCharCode(input.codeUnitAt(i + 2));

    if (currentChar.codeUnitAt(0) + 1 == nextChar.codeUnitAt(0) &&
        nextChar.codeUnitAt(0) + 1 == thirdChar.codeUnitAt(0)) {
      return true;
    }
  }

  return false;
}

/// Function to check if string contain sequential digits
bool isContainSameThreeDigits(String input) {
  RegExp regex = RegExp(r'(\d)\1{2}');
  return regex.hasMatch(input);
}

/// Function to check if password's length is 8 or more
bool isPasswordLengthCorrect(String text) {
  if (text.length < 8) {
    return false;
  }
  return true;
}
