import 'dart:math' as math;

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

  static String subnetMaskFromInt(String val) {
    String result = '';
    int mask = int.tryParse(val);
    for (var i = 0; i < 4; i++) {
      if (mask - 8 >= 0) {
        result += '255';
        mask -= 8;
      } else if (mask < 8) {
        final ones = fromOnesToBinary(mask.toString());
        result += fromBinaryToDecimal(ones);
        mask = 0;
      }
      if (i != 3) result += '.';
    }
    return result;
  }

  static int numberOfHosts(int subnetMask) => math.pow(2, 32 - subnetMask) - 2;

  static int numberOfSubnets(int subnetMask) => math.pow(2, (subnetMask % 8));

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

  static String fromOnesToBinary(String val) {
    int ones = int.tryParse(val);
    String result = '';
    for (int i = 0; i < 8; i++) {
      if (ones-- > 0)
        result += '1';
      else
        result += '0';
    }

    return result;
  }

  static String reverseBinary(String val) {
    String res = '';
    for (int i = 0; i < 8; i++) {
      if (val.length - 1 >= i && val[i] == '1') {
        res += '0';
      } else {
        res += '1';
      }
    }
    return res;
  }

  static String subnetAddress(String subnetAddress, String mask,
      {int subnet = 0}) {
    final List<String> subMask =
        (mask.length <= 2 ? subnetMaskFromInt(mask) : mask).split('.');
    final List<String> subNet = subnetAddress.split('.');
    final decimalMask =
        mask.length <= 2 ? int.tryParse(mask) : subnetMaskToInt(mask);
    final int octet = (decimalMask / 8).floor();
    final hosts = numberOfHosts(decimalMask);

    String res = '';
    for (var i = 0; i < 4; i++) {
      // Binary AND &
      int val = int.tryParse(subNet[i]) & int.tryParse(subMask[i]);

      if (i == octet) val += (subnet * (hosts + 2));

      res += val.toString();

      if (i != 3) res += '.';
    }
    return res;
  }

  static String broadcastAddress(String subnetAddress, String mask,
      {int subnet = 0}) {
    final List<String> subMask =
        (mask.length <= 2 ? subnetMaskFromInt(mask) : mask).split('.');
    final List<String> subNet = subnetAddress.split('.');
    final decimalMask =
        mask.length <= 2 ? int.tryParse(mask) : subnetMaskToInt(mask);
    final int octet = (decimalMask / 8).floor();
    final hosts = numberOfHosts(decimalMask);

    

    String res = '';
    for (var i = 0; i < 4; i++) {
      final reversedMask =
          fromBinaryToDecimal(reverseBinary(toBinaryS(subMask[i])));
      // Binary OR |
      res += (int.tryParse(subNet[i]) | int.tryParse(reversedMask)).toString();

      if (i != 3) res += '.';
    }
    return res;
  }

  static String firstHostAddress(String subnetAddress, String mask) {
    final List<String> addresses = subnetAddress.split('.');
    final int octet =
        ((mask.length <= 2 ? int.tryParse(mask) : subnetMaskToInt(mask)) / 8)
            .floor();

    String res = '';
    for (var i = 0; i < 4; i++) {
      if (i == octet) {
        res += (int.tryParse(addresses[i]) + 1).toString();
      } else {
        res += addresses[i];
      }

      if (i != 3) res += '.';
    }
    return res;
  }

  static String lastHostAddress(String subnetAddress, String mask) {
    final List<String> addresses = subnetAddress.split('.');
    final int octet =
        ((mask.length <= 2 ? int.tryParse(mask) : subnetMaskToInt(mask)) / 8)
            .floor();

    String res = '';
    for (var i = 0; i < 4; i++) {
      if (i == octet) {
        res += (int.tryParse(addresses[i]) - 1).toString();
      } else {
        res += addresses[i];
      }

      if (i != 3) res += '.';
    }
    return res;
  }
}
