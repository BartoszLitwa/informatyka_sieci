import 'dart:math' as math;

import 'package:sieci/screens/helpers.dart';
import 'package:sieci/screens/number_systems/number_systems_logic.dart';

class IPLogic {
  static const int _octets = 4, _bits = 8;

  static int numberOfHosts(int subnetMask) => math.pow(2, 32 - subnetMask) - 2;

  static int numberOfSubnets(int subnetMask) => math.pow(2, (subnetMask % 8));

  static String fromOnesToBinary(String val) {
    int ones = int.tryParse(val);
    String result = '';
    for (int i = 0; i < _bits; i++) {
      if (ones-- > 0)
        result += '1';
      else
        result += '0';
    }

    return result;
  }

  static String reverseBinary(String val) {
    String res = '';
    for (int i = 0; i < _bits; i++) {
      if (val.length - 1 >= i && val[i] == '1') {
        res += '0';
      } else {
        res += '1';
      }
    }
    return res;
  }

  static String isMaskCorrect(String val) {
    final list = Helpers.toListFromAddress(val);
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
    return (list.length == _octets && correct) ? null : 'Maska nie poprawna';
  }

  static String isIPCorrect(String val) {
    final list = Helpers.toListFromAddress(val);

    bool correct = true;
    list.forEach((String e) {
      if (e == null || e == '') e = '-1';
      final int a = int.tryParse(e);
      if (correct) correct = (a >= 0 && a <= 255);
    });
    return (list.length == _octets && correct) ? null : 'IP nie jest poprawne';
  }

  static int subnetMaskToInt(String val) {
    final list = Helpers.toListFromAddress(val);
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
        if (correct)
          binaryOnes += NumberSystemLogic.toBinary(a).split('1').length - 1;
      }
    });
    return binaryOnes;
  }

  static String subnetMaskFromInt(String val) {
    String result = '';
    int mask = int.tryParse(val);
    for (var i = 0; i < _octets; i++) {
      if (mask - _bits >= 0) {
        result += '255';
        mask -= _bits;
      } else if (mask < _bits) {
        final ones = fromOnesToBinary(mask.toString());
        result += NumberSystemLogic.fromBinaryToDecimal(ones);
        mask = 0;
      }
      if (i != 3) result += '.';
    }
    return result;
  }

  static String subnetAddress(String subnetAddress, String mask,
      {int subnet = 0}) {
    final List<String> subMask =
        (mask.length <= 2 ? subnetMaskFromInt(mask) : mask).split('.');
    final List<String> subNet = Helpers.toListFromAddress(subnetAddress);
    final decimalMask =
        mask.length <= 2 ? int.tryParse(mask) : subnetMaskToInt(mask);
    final int octet = (decimalMask / 8).floor();
    final subnets = numberOfSubnets(decimalMask);

    String res = '';
    for (var i = 0; i < _octets; i++) {
      // Binary AND &
      int val = int.tryParse(subNet[i]) & int.tryParse(subMask[i]);

      if (i > octet) {
        val += 0;
      } else if (i == octet) {
        val += math.min(255, 256 / subnets).floor() * subnet;
      }

      res += val.toString();

      if (i != 3) res += '.';
    }
    return res;
  }

  static String broadcastAddress(String subnetAddress, String mask,
      {int subnet = 0}) {
    final List<String> subMask =
        (mask.length <= 2 ? subnetMaskFromInt(mask) : mask).split('.');
    final List<String> subNet = Helpers.toListFromAddress(subnetAddress);

    String res = '';
    for (var i = 0; i < _octets; i++) {
      final reversedMask = NumberSystemLogic.fromBinaryToDecimal(
          reverseBinary(NumberSystemLogic.toBinaryS(subMask[i])));
      // Binary OR |
      res += (int.tryParse(subNet[i]) | int.tryParse(reversedMask)).toString();

      if (i != 3) res += '.';
    }
    return res;
  }

  static String firstHostAddress(String subnetAddress, String mask) {
    final List<String> addresses = Helpers.toListFromAddress(subnetAddress);

    String res = '';
    for (var i = 0; i < _octets; i++) {
      if (i == 3) {
        res += (int.tryParse(addresses[i]) + 1).toString();
      } else {
        res += addresses[i];
      }

      if (i != 3) res += '.';
    }
    return res;
  }

  static String lastHostAddress(String subnetAddress, String mask) {
    final List<String> addresses = Helpers.toListFromAddress(subnetAddress);

    String res = '';
    for (var i = 0; i < _octets; i++) {
      if (i == 3) {
        res += (int.tryParse(addresses[i]) - 1).toString();
      } else {
        res += addresses[i];
      }

      if (i != 3) res += '.';
    }
    return res;
  }

  static String firstSubnetAddress(String subnetAddress, String mask) {
    final List<String> subNet = Helpers.toListFromAddress(subnetAddress);
    final decimalMask =
        mask.length <= 2 ? int.tryParse(mask) : subnetMaskToInt(mask);
    final int octet = (decimalMask / _bits).floor();

    String res = '';
    for (var i = 0; i < 4; i++) {
      if (i >= octet)
        res += '0';
      else
        res += subNet[i];

      if (i != 3) res += '.';
    }
    return res;
  }

  static bool isIPContainedIn(String ipAddress, String subnetAddress,
      String broadcastAddress, String mask) {
    final List<String> ip = Helpers.toListFromAddress(ipAddress);
    final List<String> subnet = Helpers.toListFromAddress(subnetAddress);
    final List<String> broadcast = Helpers.toListFromAddress(broadcastAddress);
    final decimalMask =
        mask.length <= 2 ? int.tryParse(mask) : subnetMaskToInt(mask);
    final int octet = (decimalMask / 8).floor();

    bool inSubnet = true, inBroadcast = true;
    for (var i = 0; i < _octets; i++) {
      if (i >= octet) {
        inSubnet = (int.tryParse(ip[i]) >= int.tryParse(subnet[i]));
        inBroadcast = (int.tryParse(ip[i]) <= int.tryParse(broadcast[i]));

        if (inSubnet == false || inBroadcast == false) return false;
      } else {
        if (ip[i] != subnet[i] || ip[i] != broadcast[i]) return false;
      }
    }
    return (inSubnet && inBroadcast);
  }

  static int maxHostsForCustomHosts(String hosts) {
    final int customHosts = int.tryParse(hosts);

    for (int i = 31; i >= 0; i--) {
      int _hosts = numberOfHosts(i);
      if (_hosts >= customHosts) return _hosts;
    }
    return -1;
  }

  static int maskForCustomHosts(String hosts) {
    final int customHosts = int.tryParse(hosts);

    for (int i = 31; i >= 0; i--) {
      int _hosts = numberOfHosts(i);
      if (_hosts >= customHosts) return i;
    }
    return -1;
  }

  static int usedHosts(List<String> list) {
    int result = 0;
    if (list == null || list.length <= 0) return 0;
    list.forEach((e) {
      result += maxHostsForCustomHosts(e) + 2;
    });
    return result;
  }

  static int maxUsableHosts(int basicMask) {
    return numberOfHosts(basicMask);
  }

  static String addHostsToAddress(String address, int hosts) {
    List<String> _address = Helpers.toListFromAddress(address);
    List<int> _result = [0, 0, 0, 0];
    List<int> _hostsToAdd = [0, 0, 0, 0];

    final int divideBy = hosts % 255 == 0 ? 255 : 256;
    for (var i = 0; i < 4; i++) {
      final address = int.tryParse(_address[i]);
      _hostsToAdd[i] = hosts ~/ math.pow(divideBy, _octets - i - 1);
      if (_hostsToAdd[i] != 0)
        hosts -= _hostsToAdd[i] * math.pow(divideBy, _octets - i - 1);

      _result[i] = address + _hostsToAdd[i];
      if (_result[i] >= 256) {
        if (i > 0) _result[i - 1] += _result[i] ~/ 255;
        _result[i] -= 256;
      }
    }

    return _result.join('.');
  }
}
