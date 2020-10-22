import 'package:flutter/material.dart';
import 'package:sieci/constants.dart';
import 'package:provider/provider.dart';
import 'package:sieci/main.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _darkTheme = context.watch<AppTheme>().darkTheme;
    final _style = _darkTheme ? whiteStyle : blackStyle;

    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: _darkTheme ? black : Colors.grey),
            child: Column(
              children: [
                Text(
                  'Informatyka',
                  style: _style.copyWith(fontSize: biggerFontSize * 2),
                ),
                Divider(
                  color: white,
                  height: size.height / 16,
                  thickness: 2,
                ),
                Text(
                  'Stworzona przez Bartosz Litwa',
                  style: _style.copyWith(fontSize: normalFontSize),
                )
              ],
            ),
          ),
          ListTileButton(
            func: () {
              Navigator.popAndPushNamed(context, '/ipAddressScreen');
            },
            icon: Icons.network_cell,
            text: 'Sieci',
            darkTheme: _darkTheme,
          ),
          ListTileButton(
            func: () {
              Navigator.popAndPushNamed(context, '/numberSystemScreen');
            },
            icon: Icons.two_k,
            text: 'Systemy Liczbowe',
            darkTheme: _darkTheme,
          ),
          ListTileButton(
            func: () {
              Navigator.popAndPushNamed(context, '/calculatorScreen');
            },
            icon: Icons.calculate,
            text: 'Kalkulator',
            darkTheme: _darkTheme,
          ),
        ],
      ),
    );
  }
}

class ListTileButton extends StatelessWidget {
  final Function func;
  final IconData icon;
  final String text;
  final bool darkTheme;

  const ListTileButton(
      {Key key, this.func, this.icon, this.text, this.darkTheme})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _style = darkTheme ? whiteStyle : blackStyle;
    final _color = darkTheme ? white : black;

    return FlatButton(
      onPressed: func,
      child: Column(
        children: [
          ListTile(
            leading: Icon(
              icon,
              color: _color,
            ),
            title: Text(
              text,
              style: _style.copyWith(fontSize: bigFontSize),
            ),
          ),
          Divider(
            thickness: 2,
            color: _color,
          ),
        ],
      ),
    );
  }
}
