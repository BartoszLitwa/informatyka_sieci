import 'package:flutter/material.dart';
import 'package:sieci/constants.dart';
import 'package:sieci/main.dart';
import 'package:sieci/screens/home/home_screen.dart';
import 'package:sieci/screens/number_systems/custom_keyboard_number_system.dart';
import 'package:provider/provider.dart';
import 'package:sieci/screens/number_systems/number_systems_logic.dart';

class NumberSystemsScreen extends StatefulWidget {
  @override
  _NumberSystemsScreenState createState() => _NumberSystemsScreenState();
}

class _NumberSystemsScreenState extends State<NumberSystemsScreen> {
  final _formKey = GlobalKey<FormState>();
  String _binaryText = '', _octalText = '', _decimalText = '', _hexaText = '';
  FocusNode _focusNodeBIN = new FocusNode(),
      _focusNodeOCT = new FocusNode(),
      _focusNodeDEC = new FocusNode(),
      _focusNodeHEX = new FocusNode();

  TextEditingController _textBIN = new TextEditingController(),
      _textOCT = new TextEditingController(),
      _textDEC = new TextEditingController(),
      _textHEX = new TextEditingController();

  String _currentSelectedSystem = 'BIN';

  @override
  void initState() {
    super.initState();

    _focusNodeBIN.addListener(() {
      setState(() {
        _currentSelectedSystem = 'BIN';
      });
    });
    _focusNodeOCT.addListener(() {
      setState(() {
        _currentSelectedSystem = 'OCT';
      });
    });
    _focusNodeDEC.addListener(() {
      setState(() {
        _currentSelectedSystem = 'DEC';
      });
    });
    _focusNodeHEX.addListener(() {
      setState(() {
        _currentSelectedSystem = 'HEX';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    final _appTheme = context.watch<AppTheme>();
    final _colorBg = _appTheme.getColorBg();

    _currentSelectedSystem = _focusNodeBIN.hasFocus
        ? 'BIN'
        : _focusNodeOCT.hasFocus
            ? 'OCT'
            : _focusNodeDEC.hasFocus
                ? 'DEC'
                : _focusNodeHEX.hasFocus
                    ? 'HEX'
                    : '';

    return HomePage(
      child: Container(
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: _colorBg,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  NumberSystemTextField(
                    shortSys: 'BIN',
                    fullSys: 'Binarny',
                    node: _focusNodeBIN,
                    textController: _textBIN,
                  ),
                  NumberSystemTextField(
                    shortSys: 'OCT',
                    fullSys: 'Oktalny',
                    node: _focusNodeOCT,
                    textController: _textOCT,
                  ),
                  NumberSystemTextField(
                    shortSys: 'DEC',
                    fullSys: 'Dziesiętny',
                    node: _focusNodeDEC,
                    textController: _textDEC,
                  ),
                  NumberSystemTextField(
                    shortSys: 'HEX',
                    fullSys: 'Heksalny',
                    node: _focusNodeHEX,
                    textController: _textHEX,
                  ),
                ],
              ),
            ),
            CustomKeyboardNumberSystem(
              func: _updateInputText,
              currentSystem: _currentSelectedSystem,
            ),
          ],
        ),
      ),
    );
  }

  void _updateInputText(String input) {
    switch (_currentSelectedSystem) {
      case 'BIN':
        _updatedBinaryText(input);
        break;
      case 'OCT':
        _updatedOctalText(input);
        break;
      case 'DEC':
        _updatedDecimalText(input);
        break;
      case 'HEX':
        _updatedHexaText(input);
        break;
      default:
    }
  }

  void _updatedBinaryText(String input) {
    _binaryText = NumberSystemLogic.manageCalculatorSymbols(_binaryText, input);
    final decimal = NumberSystemLogic.fromBinaryToDecimal(_binaryText);
    _setBinaryText(_binaryText);
    _setOctalText(NumberSystemLogic.toNumberSystemS(decimal, 8));
    _setDeciamlText(decimal);
    _setHexalText(NumberSystemLogic.toNumberSystemS(decimal, 16));
  }

  void _updatedOctalText(String input) {
    _octalText = NumberSystemLogic.manageCalculatorSymbols(_octalText, input);
    final decimal = NumberSystemLogic.fromOctaToDecimal(_octalText);
    _setBinaryText(NumberSystemLogic.toNumberSystemS(decimal, 2));
    _setOctalText(_octalText);
    _setDeciamlText(decimal);
    _setHexalText(NumberSystemLogic.toNumberSystemS(decimal, 16));
  }

  void _updatedDecimalText(String input) {
    _decimalText =
        NumberSystemLogic.manageCalculatorSymbols(_decimalText, input);
    final decimal = _decimalText;
    _setBinaryText(NumberSystemLogic.toNumberSystemS(decimal, 2));
    _setOctalText(NumberSystemLogic.toNumberSystemS(decimal, 8));
    _setDeciamlText(decimal);
    _setHexalText(NumberSystemLogic.toNumberSystemS(decimal, 16));
  }

  void _updatedHexaText(String input) {
    _hexaText = NumberSystemLogic.manageCalculatorSymbols(_hexaText, input);
    final decimal = NumberSystemLogic.fromHexaToDecimal(_hexaText);
    _setBinaryText(NumberSystemLogic.toNumberSystemS(decimal, 2));
    _setOctalText(NumberSystemLogic.toNumberSystemS(decimal, 8));
    _setDeciamlText(decimal);
    _setHexalText(_hexaText);
  }

  void _setBinaryText(String text) {
    _binaryText = text;
    _textBIN.text = _binaryText;
  }

  void _setOctalText(String text) {
    _octalText = text;
    _textOCT.text = _octalText;
  }

  void _setDeciamlText(String text) {
    _decimalText = text;
    _textDEC.text = _decimalText;
  }

  void _setHexalText(String text) {
    _hexaText = text;
    _textHEX.text = _hexaText;
  }
}

class NumberSystemTextField extends StatelessWidget {
  final String shortSys, fullSys;
  final FocusNode node;
  final TextEditingController textController;

  const NumberSystemTextField(
      {Key key, this.shortSys, this.fullSys, this.node, this.textController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _appTheme = context.watch<AppTheme>();
    final _style = _appTheme.getStyle().copyWith(fontSize: 20);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          shortSys,
          style: _style.copyWith(fontSize: biggerFontSize),
        ),
        SizedBox(width: 20),
        SizedBox(
          width: size.width / 1.8,
          child: TextFormField(
            controller: textController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              labelText: fullSys,
              labelStyle: _style,
              border: InputBorder.none,
            ),
            focusNode: node,
            showCursor: false,
            readOnly: true,
          ),
        ),
      ],
    );
  }
}
