import 'package:flutter/material.dart';
import 'package:sieci/constants.dart';
import 'package:sieci/screens/home/home_screen.dart';
import 'package:sieci/screens/ip_address/ip_logic.dart';
import 'package:sieci/screens/ip_address/subnets_list_view.dart';

class IpAddressScreen extends StatefulWidget {
  @override
  _IpAddressScreenState createState() => _IpAddressScreenState();
}

class _IpAddressScreenState extends State<IpAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  String ipAddress, subnetMask;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return HomePage(
      child: Column(
        children: [
          SizedBox(
            height: size.height / 4,
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
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        // border: InputBorder.none,
                        hintText: '192.168.0.1',
                        labelText: 'Adres IP',
                        labelStyle: const TextStyle(color: black),
                        hintStyle: const TextStyle(color: black),
                      ),
                      keyboardType: TextInputType.number,
                      style: const TextStyle(color: black),
                      onChanged: (value) => ipAddress = value,
                      validator: (String val) => IPLogic.isIPCorrect(val),
                    ),
                    SizedBox(
                      height: 0,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: size.width / 1.8,
                          child: TextFormField(
                            decoration: InputDecoration(
                              // border: InputBorder.none,
                              hintText: '24',
                              labelText: 'Maska',
                              labelStyle: const TextStyle(color: black),
                              hintStyle: const TextStyle(color: black),
                            ),
                            keyboardType: TextInputType.number,
                            style: const TextStyle(color: black),
                            onChanged: (value) => subnetMask = value,
                            validator: (String val) =>
                                IPLogic.isMaskCorrect(val),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 15),
                          child: Builder(
                            builder: (context) => RaisedButton(
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                      content: const Text(
                                    'Przetwarzanie danych!',
                                    style: const TextStyle(color: green),
                                  )));
                                } else {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                      content: const Text(
                                    'Maska lub IP są nie poprawne!',
                                    style: const TextStyle(color: red),
                                  )));
                                }
                              },
                              color: blue,
                              child: Text('OK'),
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
            height: 10,
          ),
          SubnetsListView(ipAddress: ipAddress, subnetMask: subnetMask),
        ],
      ),
    );
  }
}
