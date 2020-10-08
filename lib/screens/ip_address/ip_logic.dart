import 'dart:math' as math;
import 'dart:async';

class IPLogic {
  static String isMaskCorrect(String val) {
    final list = val.toString().split('.');
    if (list.length == 1) {
      int a = int.tryParse(list.first);
      if (a == null) a = 0;
      return a > 0 && a < 32 ? null : 'Maska nie poprawna';
    }

    bool correct = true;
    list.forEach((String e) {
      if (e == null || e == '') e = '-1';
      final int a = int.tryParse(e);
      if (correct) correct = (a >= 0 && a <= 255);
    });
    return (list.length == 4 && correct) ? null : 'Maska nie poprawna';
  }

  static String isIPCorrect(String val) {
    final list = val.toString().split('.');

    bool correct = true;
    list.forEach((String e) {
      if (e == null || e == '') e = '-1';
      final int a = int.tryParse(e);
      if (correct) correct = (a >= 0 && a <= 255);
    });
    return (list.length == 4 && correct) ? null : 'IP nie jest poprawne';
  }

  static int subnetMaskToInt(String val) {
    final list = val.toString().split('.');
    if (list.length == 1) {
      return int.tryParse(list.first);
    }

    bool correct = true;
    int binaryOnes = 0;
    list.forEach((String e) {
      if (e == null || e == '') e = '0';
      final int a = int.tryParse(e);
      if (correct) {
        correct = (a >= 0 && a <= 255);
        if (correct) binaryOnes += toBinary(a).split('1').length - 1;
      }
    });
    return binaryOnes;
  }

  static int numberOfHosts(int subnetMask) => math.pow(2, 32 - subnetMask) - 2;

  static int numberOfSubnets(int subnetMask) => math.pow(2, (subnetMask % 8));

  static String toBinary(int val) => val.toRadixString(2);
}
