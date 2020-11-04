import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sieci/constants.dart';
import 'package:sieci/main.dart';
import 'package:sieci/screens/number_systems/number_systems_logic.dart';

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
  Color colorOfButton(String button, Color color) {
    return NumberSystemLogic.isSystemOn(button, widget.currentSystem)
        ? color
        : grey;
  }

  void onPressedButton(String button) {
    setState(() {
      return NumberSystemLogic.isSystemOn(button, widget.currentSystem)
          ? widget.func(button)
          : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _appTheme = context.watch<AppTheme>();
    final textSize = _appTheme.width * _appTheme.width / 4000;
    final style = _appTheme.getStyle().copyWith(fontSize: textSize);
    final colorBg = _appTheme.getColorBg();
    final colorText = _appTheme.getColorText();
    //    CE <
    // 7 8 9 F
    // 4 5 6 E
    // 1 2 3 D
    // 0 A B C
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: colorBg,
          borderRadius: BorderRadius.circular(_appTheme.space),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _customButton('', style, colorBg, colorText),
                _customButton('', style, colorBg, colorText),
                _customButton('X', style, colorBg, colorText),
                FlatButton(
                  onPressed: () => onPressedButton('-'),
                  color: colorBg,
                  child: RotatedBox(
                    quarterTurns: 2, // Rotate by 180 degrees
                    child: SizedBox(
                      child: Icon(
                        Icons.send,
                        size: textSize * 1.45,
                        color: colorText,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _customButton('7', style, colorBg, colorText),
                _customButton('8', style, colorBg, colorText),
                _customButton('9', style, colorBg, colorText),
                _customButton('F', style, colorBg, colorText),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _customButton('4', style, colorBg, colorText),
                _customButton('5', style, colorBg, colorText),
                _customButton('6', style, colorBg, colorText),
                _customButton('E', style, colorBg, colorText),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _customButton('1', style, colorBg, colorText),
                _customButton('2', style, colorBg, colorText),
                _customButton('3', style, colorBg, colorText),
                _customButton('D', style, colorBg, colorText),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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

  Widget _customButton(
      String buttonText, TextStyle style, Color color, Color colorText) {
    return Expanded(
      child: FlatButton(
        onPressed: () => onPressedButton(buttonText),
        color: color,
        child: Text(buttonText,
            style: style.copyWith(color: colorOfButton(buttonText, colorText))),
      ),
    );
  }
}
