import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sieci/constants.dart';
import 'package:sieci/main.dart';

class CustomKeyboardNumberSystem extends StatefulWidget {
  final Function(String) func;
  final String currentSystem;

  const CustomKeyboardNumberSystem({Key key, this.func, this.currentSystem})
      : super(key: key);

  @override
  _CustomKeyboardNumberSystemState createState() =>
      _CustomKeyboardNumberSystemState();
}

class _CustomKeyboardNumberSystemState
    extends State<CustomKeyboardNumberSystem> {
  bool isSystemOn(String button) {
    if (button == 'CE' || button == '-') return true;
    final val = int.tryParse(button) ?? 100;
    switch (widget.currentSystem) {
      case 'BIN':
        return val <= 1;
      case 'OCT':
        return val <= 7;
      case 'DEC':
        return val <= 9;
      case 'HEX':
        return true;
      default:
        return true;
    }
  }

  Color colorOfButton(String button, Color color) {
    return isSystemOn(button) ? color : grey;
  }

  void onPressedButton(String button) {
    setState(() {
      return isSystemOn(button) ? widget.func(button) : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final appTheme = context.watch<AppTheme>();
    final style = appTheme.getStyle().copyWith(fontSize: 50);
    final colorBg = appTheme.getColorBg();
    final colorText = appTheme.getColorText();
    //    CE <
    // 7 8 9 F
    // 4 5 6 E
    // 1 2 3 D
    // 0 A B C
    return SizedBox(
      height: size.height / 2.75,
      child: Container(
        decoration: BoxDecoration(
          color: colorBg,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _customButton('CE', style, colorBg, colorText),
                FlatButton(
                  onPressed: () => onPressedButton('-'),
                  color: colorBg,
                  child: RotatedBox(
                    quarterTurns: 2, // Rotate by 180 degrees
                    child: Icon(
                      Icons.send,
                      color: colorText,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                _customButton('7', style, colorBg, colorText),
                _customButton('8', style, colorBg, colorText),
                _customButton('9', style, colorBg, colorText),
                _customButton('F', style, colorBg, colorText),
              ],
            ),
            Row(
              children: [
                _customButton('4', style, colorBg, colorText),
                _customButton('5', style, colorBg, colorText),
                _customButton('6', style, colorBg, colorText),
                _customButton('E', style, colorBg, colorText),
              ],
            ),
            Row(
              children: [
                _customButton('1', style, colorBg, colorText),
                _customButton('2', style, colorBg, colorText),
                _customButton('3', style, colorBg, colorText),
                _customButton('D', style, colorBg, colorText),
              ],
            ),
            Row(
              children: [
                _customButton('0', style, colorBg, colorText),
                _customButton('A', style, colorBg, colorText),
                _customButton('B', style, colorBg, colorText),
                _customButton('C', style, colorBg, colorText),
              ],
            )
          ],
        ),
      ),
    );
  }

  FlatButton _customButton(
      String buttonText, TextStyle style, Color color, Color colorText) {
    return FlatButton(
      onPressed: () => onPressedButton(buttonText),
      color: color,
      child: Text(buttonText,
          style: style.copyWith(color: colorOfButton(buttonText, colorText))),
    );
  }
}
