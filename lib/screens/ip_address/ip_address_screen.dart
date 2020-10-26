import 'package:flutter/material.dart';
import 'package:sieci/constants.dart';
import 'package:sieci/main.dart';
import 'package:sieci/screens/home/home_screen.dart';
import 'package:sieci/screens/ip_address/bottomSheet_additional_settings.dart';
import 'package:sieci/screens/ip_address/custom_subnets_list_view.dart';
import 'package:sieci/screens/ip_address/ip_logic.dart';
import 'package:sieci/screens/ip_address/subnets_list_view.dart';
import 'package:provider/provider.dart';

class IpAddressScreen extends StatefulWidget {
  @override
  _IpAddressScreenState createState() => _IpAddressScreenState();
}

class _IpAddressScreenState extends State<IpAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  String ipAddress = '', subnetMask = '';
  bool _pressedOK = false,
      _ipOnlyContainedChecked = false,
      _variableMaskChecked = false,
      _isTextIPFocused = false,
      _isTextMaskFocused = false,
      _isTextFieldsFocused = false,
      _settingsOpened = false;

  FocusNode _focusNodeIP = new FocusNode();
  FocusNode _focusNodeMask = new FocusNode();
  //TextEditingController _controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _focusNodeIP.addListener(() {
      _isTextIPFocused = !_isTextIPFocused;
      if (_isTextIPFocused) _isTextFieldsFocused = true;
    });

    _focusNodeMask.addListener(() {
      _isTextMaskFocused = !_isTextMaskFocused;
      if (_isTextMaskFocused) _isTextFieldsFocused = true;
    });

    setState(() {
      _isTextFieldsFocused = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _appTheme = context.watch<AppTheme>();
    final _style = _appTheme.getStyle();
    final _colorBg = _appTheme.getColorBg();
    final _color = _appTheme.getColorText();

    return HomePage(
      child: Column(
        children: [
          SizedBox(
            height: size.height / 3.12,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: _colorBg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: size.height / 10.5,
                      child: Row(
                        children: [
                          SizedBox(
                            width: size.width / 1.9,
                            child: TextFormField(
                              autofocus: true,
                              decoration: InputDecoration(
                                // border: InputBorder.none,
                                labelText: 'Adres IP',
                                labelStyle:
                                    _style.copyWith(fontSize: bigFontSize),
                                hintStyle: _style,
                              ),
                              keyboardType: TextInputType.number,
                              style: _style,
                              focusNode: _focusNodeIP,
                              onChanged: (value) {
                                if (value != null) ipAddress = value;
                              },
                              validator: (String val) =>
                                  IPLogic.isIPCorrect(val),
                            ),
                          ),
                          SizedBox(
                            width: 0,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 3, vertical: 5),
                            decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              children: [
                                Checkbox(
                                  value: _ipOnlyContainedChecked,
                                  onChanged: (val) => setState(
                                      () => _ipOnlyContainedChecked = val),
                                  checkColor: black,
                                  activeColor: green,
                                ),
                                Text(
                                  ' Tylko  \npodsieć   \n  z IP',
                                  softWrap: true,
                                  style: _style,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 0,
                    ),
                    SizedBox(
                      height: size.height / 10.5,
                      child: Row(
                        children: [
                          SizedBox(
                            width: size.width / 1.9,
                            child: TextFormField(
                              decoration: InputDecoration(
                                // border: InputBorder.none,
                                labelText: 'Maska',
                                labelStyle:
                                    _style.copyWith(fontSize: bigFontSize),
                                hintStyle: _style,
                              ),
                              keyboardType: TextInputType.number,
                              style: _style,
                              focusNode: _focusNodeMask,
                              onChanged: (value) {
                                if (value != null) subnetMask = value;
                                _isTextFieldsFocused =
                                    !_formKey.currentState.validate() ||
                                        _isTextIPFocused ||
                                        _isTextMaskFocused;
                              },
                              validator: (String val) =>
                                  IPLogic.isMaskCorrect(val),
                            ),
                          ),
                          SizedBox(
                            width: 0,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 3, vertical: 5),
                            decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              children: [
                                Checkbox(
                                  value: _variableMaskChecked,
                                  onChanged: (val) => setState(
                                      () => _variableMaskChecked = val),
                                  checkColor: black,
                                  activeColor: green,
                                ),
                                Text(
                                  'Zmienna \nMaska',
                                  softWrap: true,
                                  style: _style,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Builder(
                          builder: (context) => ElevatedButton.icon(
                            onPressed: () {
                              showModalBottomSheet<void>(
                                  isScrollControlled: false,
                                  context: context,
                                  builder: (context) =>
                                      AdditionalSettingsBottomSheet(
                                        basicMask: subnetMask,
                                      ));
                              setState(() {
                                _settingsOpened = !_settingsOpened;
                              });
                            },
                            icon: Icon(
                              Icons.settings,
                              color: _color,
                            ),
                            label: Text('Dodatkowe ustawienia', style: _style),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 20),
                          child: Builder(
                            builder: (context) => ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  FocusScope.of(context).unfocus();

                                  Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text(
                                    'Przetwarzanie danych!',
                                    style: _style.copyWith(color: green),
                                  )));
                                  setState(() {
                                    _pressedOK = true;
                                    _isTextFieldsFocused = false;
                                    _isTextIPFocused = false;
                                    _isTextMaskFocused = false;
                                  });
                                } else {
                                  setState(() {
                                    _pressedOK = false;
                                  });
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text(
                                    'Maska lub IP są nie poprawne!',
                                    style: _style.copyWith(color: red),
                                  )));
                                }
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.check,
                                    color: _color,
                                  ),
                                  Text(
                                    'OK',
                                    style:
                                        _style.copyWith(fontSize: bigFontSize),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: (!_isTextFieldsFocused)
                ? size.height / 1.745
                : size.height / 3.29,
            child: _pressedOK
                ? (_variableMaskChecked
                    ? CustomSubnetsListView(
                        ip: ipAddress,
                        subnetMask: subnetMask,
                        onlyConatainedInIP: _ipOnlyContainedChecked,
                      )
                    : SubnetsListView(
                        ip: ipAddress,
                        subnetMask: subnetMask,
                        onlyConatainedInIP: _ipOnlyContainedChecked,
                      ))
                : Container(height: 10, width: 10),
          ),
        ],
      ),
    );
  }
}
