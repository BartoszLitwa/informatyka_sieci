import 'package:flutter/material.dart';
import 'package:sieci/constants.dart';
import 'package:sieci/main.dart';
import 'package:provider/provider.dart';

class SubnetItem extends StatelessWidget {
  final String subnetAddress, broadcastAddress, firstHost, lastHost;
  final int numberOfHosts, subnet, mask;
  final bool ipisContained;

  const SubnetItem(
      {Key key,
      this.subnet,
      this.subnetAddress,
      this.broadcastAddress,
      this.firstHost,
      this.lastHost,
      this.numberOfHosts,
      this.ipisContained,
      this.mask})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _appTheme = context.watch<AppTheme>();
    final _style = _appTheme.getStyle();
    final _colorBg = _appTheme.getColorBg();

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_appTheme.space),
        color: ipisContained ? green : _colorBg,
      ),
      child: Column(
        children: [
          SizedBox(height: _appTheme.smallSpace),
          Center(
              child: Text(
                  'Podsieć ${subnet + 1}          ${mask != null ? '/$mask' : ''}',
                  style: _style.copyWith(fontSize: bigFontSize))),
          IconText(text: subnetAddress, title: 'Adres Sieci'),
          IconText(text: broadcastAddress, title: 'Adres Rozgłoszeniowy'),
          IconText(text: firstHost, title: 'Pierwszy Host'),
          IconText(text: lastHost, title: 'Ostatni Host'),
          IconText(text: numberOfHosts.toString(), title: 'Ilość Hostów'),
        ],
      ),
    );
  }
}

class IconText extends StatelessWidget {
  final String text, title;
  final IconData icon;

  const IconText({Key key, this.text, this.title, this.icon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _appTheme = context.watch<AppTheme>();
    final _style = _appTheme.getStyle();

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: _appTheme.bigerSpace, vertical: _appTheme.smallerSpace),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: _appTheme.smallerSpace),
            icon != null
                ? Icon(icon)
                : Center(child: Text('$title: ', style: _style)),
            SizedBox(width: _appTheme.smallerSpace),
            Center(child: Text(text, style: _style)),
            SizedBox(height: _appTheme.smallerSpace),
          ],
        ),
      ),
    );
  }
}
