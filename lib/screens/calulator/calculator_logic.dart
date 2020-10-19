import 'dart:math' as math;

class CalcLogic {
  static String divide(num a, num b, {int fractionDigits = 2}) {
    return (a / b).toStringAsFixed(fractionDigits);
  }

  static String multiplie(num a, num b, {int fractionDigits = 2}) {
    return (a * b).toStringAsFixed(fractionDigits);
  }

  static String add(num a, num b, {int fractionDigits = 2}) {
    return (a + b).toStringAsFixed(fractionDigits);
  }

  static String subtract(num a, num b, {int fractionDigits = 2}) {
    return (a - b).toStringAsFixed(fractionDigits);
  }

  static String pow(num a, num exponent, {int fractionDigits = 2}) {
    return math.pow(a, exponent).toStringAsFixed(fractionDigits);
  }
}
