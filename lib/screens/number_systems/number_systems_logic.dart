class NumberSystemLogic {
  static String isCustomHostsCorrect(String val) {
    return val.isEmpty || val == null || !isDecimalNumberCorrect(val)
        ? 'Nie poprawna liczba'
        : null;
  }

  static bool isHexaNumberCorrect(String val) {
    RegExp exp = new RegExp("^[0-9a-f]+\$", caseSensitive: false);
    return exp.hasMatch(val);
  }

  static bool isOctaNumberCorrect(String val) {
    RegExp exp = new RegExp("^[0-7]+\$", caseSensitive: false);
    return exp.hasMatch(val);
  }

  static bool isBinaryNumberCorrect(String val) {
    RegExp exp = new RegExp("^[0-1]+\$", caseSensitive: false);
    return exp.hasMatch(val);
  }

  static bool isDecimalNumberCorrect(String val) {
    RegExp exp = new RegExp("^[0-9]+\$", caseSensitive: false);
    return exp.hasMatch(val);
  }
}
