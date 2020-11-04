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

  static String toBinary(int val) {
    return val == null || val.isNaN ? '' : val.toRadixString(2);
  }

  static String toBinaryS(String val) => toBinary(int.tryParse(val));

  static String toNumberSystem(int val, int system) {
    return val == null || val.isNaN ? '' : val.toRadixString(system);
  }

  static String toNumberSystemS(String val, int system) =>
      toNumberSystem(int.tryParse(val), system);

  static String fromBinaryToDecimal(String val) {
    int result = 0, multiplier = 1;
    for (var i = val.length - 1; i >= 0; i--) {
      if (val[i] == '1') result += multiplier;

      multiplier *= 2;
    }
    return result.toString();
  }

  static String fromHexaToDecimal(String val) {
    int result = 0, multiplier = 1;
    for (var i = val.length - 1; i >= 0; i--) {
      switch (val[i].toLowerCase()) {
        case 'a':
          result += multiplier * 10;
          break;
        case 'b':
          result += multiplier * 11;
          break;
        case 'c':
          result += multiplier * 12;
          break;
        case 'd':
          result += multiplier * 13;
          break;
        case 'e':
          result += multiplier * 14;
          break;
        case 'f':
          result += multiplier * 15;
          break;
        default:
          result += multiplier * int.tryParse(val[i]);
          break;
      }
      multiplier *= 16;
    }

    return result.toString();
  }

  static String fromOctaToDecimal(String val) {
    int result = 0, multiplier = 1;
    for (var i = val.length - 1; i >= 0; i--) {
      result += multiplier * int.tryParse(val[i]);
      multiplier *= 8;
    }

    return result.toString();
  }

  static String manageCalculatorSymbols(String text, String input) {
    switch (input) {
      case '-':
        return text.length <= 1 ? '0' : text.substring(0, text.length - 1);
      case 'X':
        return '0';
      default:
        if (text == '0') text = '';
        return text + input;
    }
  }

  static int numberSystemToInt(String system) {
    switch (system) {
      case 'BIN':
        return 1;
      case 'OCT':
        return 2;
      case 'DEC':
        return 3;
      case 'HEX':
        return 4;
      default:
        return 0;
    }
  }

  static bool isSystemOn(String button, String currentSystem) {
    if (button == 'X' || button == '-') return true;
    final val = int.tryParse(button) ?? 100;
    switch (currentSystem) {
      case 'BIN':
        return val <= 1;
      case 'OCT':
        return val <= 7;
      case 'DEC':
        return val <= 9;
      case 'HEX':
        return true;
      default:
        return true;
    }
  }
}
