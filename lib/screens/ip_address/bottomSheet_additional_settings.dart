import 'package:flutter/material.dart';
import 'package:sieci/constants.dart';
import 'package:sieci/main.dart';
import 'package:sieci/screens/ip_address/data_table_custom_hosts.dart';
import 'package:provider/provider.dart';
import 'package:sieci/screens/ip_address/ip_logic.dart';
import 'package:sieci/screens/number_systems/number_systems_logic.dart';

class AdditionalSettingsBottomSheet extends StatelessWidget {
  final String basicMask;

  const AdditionalSettingsBottomSheet({Key key, this.basicMask})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    // final CustomHosts hosts = context.watch<CustomHosts>();

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
        color: white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Dodatkowe ustawienia',
                  style: TextStyle(
                    color: black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.exit_to_app),
                )
              ],
            ),
            AddHostsButton(),
            DataTableCustomHosts(),
            SizedBox(
              height: 15,
            ),
            UsageOfHosts(basicMask: int.tryParse(basicMask)),
          ],
        ),
      ),
    );
  }
}

class UsageOfHosts extends StatelessWidget {
  final int basicMask;

  const UsageOfHosts({Key key, this.basicMask}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final CustomHosts hosts = context.watch<CustomHosts>();
    final String freeHosts = basicMask == null
        ? 'Nie podano Maski'
        : IPLogic.maxUsableHosts(basicMask).toString();

    final Color color = basicMask == null ? red : green;
    final int usedHosts = IPLogic.usedHosts(hosts.hosts);
    final int leftFreeHosts =
        basicMask != null ? IPLogic.maxUsableHosts(basicMask) - usedHosts : 0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Użyte: ${usedHosts.toString()}',
          style: blackStyle.copyWith(fontSize: 15),
        ),
        Text(
          '  |  ',
          style: blackStyle.copyWith(fontSize: 20),
        ),
        Text(
          'Wszytskie: $freeHosts',
          style: blackStyle.copyWith(fontSize: 15, color: color),
        ),
        basicMask != null
            ? Text(
                '  |  ',
                style: blackStyle.copyWith(fontSize: 20),
              )
            : Container(),
        basicMask != null && leftFreeHosts >= 0
            ? Text(
                'Pozostałe: ${leftFreeHosts.toString()}',
                style: blackStyle.copyWith(fontSize: 15, color: color),
              )
            : Container(),
        basicMask != null && leftFreeHosts < 0
            ? Text(
                'Za dużo Hostów!',
                style: blackStyle.copyWith(fontSize: 15, color: red),
              )
            : Container(),
      ],
    );
  }
}

class AddHostsButton extends StatelessWidget {
  static String customHost = '';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final CustomHosts hosts = context.watch<CustomHosts>();

    return SizedBox(
      height: size.height / 18,
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: size.width / 2,
              child: TextFormField(
                decoration: InputDecoration(
                  // border: InputBorder.none,
                  labelText: customHost.isEmpty ? 'Liczba Hostów' : '',
                  labelStyle: blackStyle.copyWith(fontSize: 20),
                  hintStyle: blackStyle,
                ),
                keyboardType: TextInputType.number,
                style: const TextStyle(color: black),
                onChanged: (value) => customHost = value,
                validator: (String val) =>
                    NumberSystemLogic.isCustomHostsCorrect(val),
              ),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                if (NumberSystemLogic.isCustomHostsCorrect(customHost) ==
                    null) {
                  hosts.add(customHost);
                  customHost = '';
                } else {}
              },
              child: Row(
                children: [
                  Icon(Icons.add),
                  SizedBox(width: 10),
                  Text(
                    'Dodaj',
                    style: blackStyle.copyWith(color: white, fontSize: 18),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
