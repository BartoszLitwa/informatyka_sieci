import 'package:flutter/material.dart';
import 'package:sieci/screens/ip_address/ip_address_screen.dart';
import 'package:sieci/screens/number_systems/number_systems_screen.dart';

void main() {
  runApp(MyApp());
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
      },
    );
  }
}
