import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sieci/screens/calulator/calculator_screen.dart';
import 'package:sieci/screens/ip_address/ip_address_screen.dart';
import 'package:sieci/screens/number_systems/number_systems_screen.dart';
import 'package:sieci/test/tests.dart';

void main() {
  Tests.run();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => CustomHosts(),
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Informatyka",
      theme: ThemeData.dark(),
      initialRoute: '/ipAddressScreen',
      routes: {
        '/ipAddressScreen': (_) => IpAddressScreen(),
        '/numberSystemScreen': (_) => NumberSystemsScreen(),
        '/calculatorScreen': (_) => CalculatorScreen(),
      },
    );
  }
}

/// Mix-in [DiagnosticableTreeMixin] to have access to [debugFillProperties] for the devtool
class CustomHosts with ChangeNotifier, DiagnosticableTreeMixin {
  List<String> _hosts = new List<String>();
  List<String> get hosts => _hosts;

  void remove(int i) {
    _hosts.removeAt(i);
    notifyListeners();
  }

  void add(String val) {
    _hosts.add(val);
    notifyListeners();
  }

  /// Makes `CustomHosts` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty('hosts', hosts));
  }
}
