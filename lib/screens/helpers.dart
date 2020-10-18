class Helpers {
  static List<String> toListFromAddress(String val) => val.split('.');
  static String toAddressFromList(List<String> val) => val.join('.');

  static String toBinary(int val) => val.toRadixString(2);
  static String toBinaryS(String val) => toBinary(int.tryParse(val));

  static String toNumberSystem(int val, int system) =>
      val.toRadixString(system);

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
}
