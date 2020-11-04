import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sieci/constants.dart';
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
      ),
      ChangeNotifierProvider(
        create: (_) => AppTheme(),
      ),
      ChangeNotifierProvider(
        create: (_) => CurrentNumberSystem(),
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
      theme: context.watch<AppTheme>().darkTheme
          ? ThemeData.dark()
          : ThemeData.light(),
      themeMode: ThemeMode.system,
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

/// Mix-in [DiagnosticableTreeMixin] to have access to [debugFillProperties] for the devtool
class AppTheme with ChangeNotifier, DiagnosticableTreeMixin {
  bool _darkTheme = true;
  double _height, _width;
  bool get darkTheme => _darkTheme;
  double get height => _height;
  double get width => _width;

  void changeTheme() {
    _darkTheme = !_darkTheme;
    notifyListeners();
  }

  void setupRes(Size size) {
    _height = size.height;
    _width = size.width;
  }

  double get space => _width / 25;
  double get smallSpace => space * 2 / 3;
  double get smallerSpace => space * 1 / 3;
  double get bigSpace => space * 4 / 3;
  double get bigerSpace => space * 2;

  Color getColorText() {
    return _darkTheme ? white : black;
  }

  Color getColorBg() {
    return _darkTheme ? Colors.black54 : Colors.white70;
  }

  TextStyle getStyle() {
    return _darkTheme ? whiteStyle : blackStyle;
  }

  /// Makes `CustomHosts` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    //properties.add(FlagProperty('hosts', _darkTheme));
  }
}

class CurrentNumberSystem with ChangeNotifier, DiagnosticableTreeMixin {
  String _current = '';
  String get current => _current;

  void set(String sys) {
    _current = sys ?? '';
    notifyListeners();
  }

  /// Makes `CustomHosts` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('currentNumberSystem', _current));
  }
}
