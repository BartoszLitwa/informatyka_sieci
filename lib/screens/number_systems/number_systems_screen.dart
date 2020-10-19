import 'package:flutter/material.dart';
import 'package:sieci/constants.dart';
import 'package:sieci/screens/home/home_screen.dart';
import 'package:sieci/screens/number_systems/custom_keyboard_number_system.dart';

class NumberSystemsScreen extends StatefulWidget {
  @override
  _NumberSystemsScreenState createState() => _NumberSystemsScreenState();
}

class _NumberSystemsScreenState extends State<NumberSystemsScreen> {
  final _formKey = GlobalKey<FormState>();
  String _binaryText = '', _octalText = '', _decimalText = '', _hexaText = '';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return HomePage(
      child: Container(
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  NumberSystemTextField(shortSys: 'BIN', fullSys: 'Binarny'),
                  NumberSystemTextField(shortSys: 'OCT', fullSys: 'Oktalny'),
                  NumberSystemTextField(shortSys: 'DEC', fullSys: 'Dziesiętny'),
                  NumberSystemTextField(shortSys: 'HEX', fullSys: 'Heksalny'),
                ],
              ),
            ),
            CustomKeyboardNumberSystem(),
          ],
        ),
      ),
    );
  }

  Widget _buildNumberSystemTextField(String shortSys, String fullSys) {
    return Container();
  }
}

class NumberSystemTextField extends StatelessWidget {
  final String shortSys, fullSys;

  const NumberSystemTextField({Key key, this.shortSys, this.fullSys})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          shortSys,
          style: blackStyle.copyWith(fontSize: biggerFontSize),
        ),
        SizedBox(width: 20),
        SizedBox(
          width: size.width / 3,
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              labelText: fullSys,
              labelStyle: blackStyle,
            ),
            keyboardType: TextInputType.datetime,
          ),
        ),
      ],
    );
  }
}
