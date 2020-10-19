import 'package:flutter/material.dart';
import 'package:sieci/constants.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: blue
                //border: Border(bottom: BorderSide.merge(a, b))
                ),
            child: Column(
              children: [
                Text(
                  'Informatyka',
                  style: whiteStyle.copyWith(fontSize: biggerFontSize * 2),
                ),
                Divider(
                  color: white,
                  height: size.height / 16,
                  thickness: 2,
                ),
                Text(
                  'Stworzona przez Bartosz Litwa',
                  style: whiteStyle.copyWith(fontSize: normalFontSize),
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
          ),
          ListTileButton(
            func: () {
              Navigator.popAndPushNamed(context, '/numberSystemScreen');
            },
            icon: Icons.two_k,
            text: 'Systemy Liczbowe',
          ),
          ListTileButton(
            func: () {
              Navigator.popAndPushNamed(context, '/calculatorScreen');
            },
            icon: Icons.calculate,
            text: 'Kalkulator',
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

  const ListTileButton({Key key, this.func, this.icon, this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: func,
      child: Column(
        children: [
          ListTile(
            leading: Icon(icon),
            title: Text(
              text,
              style: whiteStyle.copyWith(fontSize: bigFontSize),
            ),
          ),
          Divider(
            thickness: 2,
          ),
        ],
      ),
    );
  }
}
