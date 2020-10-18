import 'package:flutter/material.dart';
import 'package:sieci/constants.dart';
import 'package:sieci/screens/home/home_screen.dart';
import 'package:sieci/screens/ip_address/bottomSheet_additional_settings.dart';
import 'package:sieci/screens/ip_address/custom_subnets_list_view.dart';
import 'package:sieci/screens/ip_address/ip_logic.dart';
import 'package:sieci/screens/ip_address/subnets_list_view.dart';

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

    return HomePage(
      child: Column(
        children: [
          SizedBox(
            height: size.height / 3.27,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border(),
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
                                hintText: '192.168.0.1',
                                labelText: 'Adres IP',
                                labelStyle: blackStyle.copyWith(fontSize: 20),
                                hintStyle: blackStyle,
                              ),
                              keyboardType: TextInputType.number,
                              style: const TextStyle(color: black),
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
                                  style: TextStyle(
                                      color: black,
                                      fontWeight: FontWeight.bold),
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
                                hintText: '24',
                                labelText: 'Maska',
                                labelStyle: blackStyle.copyWith(fontSize: 20),
                                hintStyle: blackStyle,
                              ),
                              keyboardType: TextInputType.number,
                              style: const TextStyle(color: black),
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
                                  style: TextStyle(
                                      color: black,
                                      fontWeight: FontWeight.bold),
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
                              color: white,
                            ),
                            label: Text('Dodatkowe ustawienia',
                                style: TextStyle(color: white)),
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
                                      content: const Text(
                                    'Przetwarzanie danych!',
                                    style: const TextStyle(color: green),
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
                                      content: const Text(
                                    'Maska lub IP są nie poprawne!',
                                    style: const TextStyle(color: red),
                                  )));
                                }
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.check),
                                  Text(
                                    'OK',
                                    style: blackStyle.copyWith(
                                        fontSize: 20, color: white),
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
                ? size.height / 1.68
                : size.height / 2.815,
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
