import 'dart:math' as math;
import 'package:sieci/screens/helpers.dart';

class Tests {
  static void run() {}

  static const int _octets = 4;
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
      print(address);
      print(_hostsToAdd[i]);

      _result[i] = address + _hostsToAdd[i];
      if (_result[i] >= 256) {
        if (i > 0) _result[i - 1] += _result[i] ~/ 255;
        _result[i] -= 256;
      }
      print(_result[i]);

      print('\n');
    }

    return _result.join('.');
  }
}
