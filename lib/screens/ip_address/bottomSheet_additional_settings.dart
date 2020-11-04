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
    final _appTheme = context.watch<AppTheme>();
    final _style = _appTheme.getStyle();
    final _colorBg = _appTheme.getColorBg();

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
        color: _colorBg,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Dodatkowe ustawienia',
                  style: _style.copyWith(fontSize: biggerFontSize),
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
              height: _appTheme.space,
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
    final _appTheme = context.watch<AppTheme>();
    final _style = _appTheme.getStyle();

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
          style: _style.copyWith(fontSize: normalFontSize),
        ),
        Text(
          '  |  ',
          style: _style.copyWith(fontSize: bigFontSize),
        ),
        Text(
          'Wszytskie: $freeHosts',
          style: _style.copyWith(fontSize: normalFontSize, color: color),
        ),
        basicMask != null
            ? Text(
                '  |  ',
                style: _style.copyWith(fontSize: bigFontSize),
              )
            : Container(),
        basicMask != null && leftFreeHosts >= 0
            ? Text(
                'Pozostałe: ${leftFreeHosts.toString()}',
                style: _style.copyWith(fontSize: normalFontSize, color: color),
              )
            : Container(),
        basicMask != null && leftFreeHosts < 0
            ? Text(
                'Za dużo Hostów!',
                style: _style.copyWith(fontSize: normalFontSize, color: red),
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
    final _appTheme = context.watch<AppTheme>();
    final _style = _appTheme.getStyle();
    print(_appTheme.space);

    return SizedBox(
      height: size.height / 18,
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Liczba\nHostów',
              style: _style,
            ),
            SizedBox(width: _appTheme.space),
            SizedBox(
              width: _appTheme.width / 3,
              child: TextFormField(
                decoration: InputDecoration(
                  labelStyle: _style.copyWith(fontSize: bigFontSize),
                  hintStyle: _style,
                ),
                keyboardType: TextInputType.number,
                style: _style,
                onChanged: (value) => customHost = value,
                validator: (String val) =>
                    NumberSystemLogic.isCustomHostsCorrect(val),
              ),
            ),
            SizedBox(width: _appTheme.space),
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
                  SizedBox(width: _appTheme.space),
                  Text(
                    'Dodaj',
                    style: whiteStyle.copyWith(fontSize: bigFontSize),
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
