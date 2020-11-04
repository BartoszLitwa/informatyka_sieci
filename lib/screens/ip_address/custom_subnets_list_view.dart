import 'package:flutter/material.dart';
import 'package:sieci/main.dart';
import 'package:sieci/screens/ip_address/ip_logic.dart';
import 'package:sieci/screens/ip_address/subnet_item.dart';
import 'package:provider/provider.dart';

class CustomSubnetsListView extends StatelessWidget {
  final String ip, subnetMask;
  final bool onlyConatainedInIP;

  CustomSubnetsListView(
      {Key key, this.ip, this.subnetMask, this.onlyConatainedInIP})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _appTheme = context.watch<AppTheme>();

    List<String> _hosts = context.watch<CustomHosts>().hosts;
    _hosts.sort((f, s) => int.tryParse(s).compareTo(int.tryParse(f)));

    return SizedBox(
      height: _appTheme.height / 1.56 - 1,
      width: _appTheme.width / 1.2,
      child: Container(
        child: ListView(
          children: _customSubnetItems(_hosts, space: _appTheme.space),
        ),
      ),
    );
  }

  List<Widget> _customSubnetItems(List<String> _hosts, {double space = 15}) {
    String _lastSubnetAddress = IPLogic.firstSubnetAddress(ip, subnetMask);
    List<Widget> _customSubnetList = new List<Widget>();

    for (var i = 0; i < _hosts.length; i++) {
      final String _host = _hosts[i];
      final int _mask = IPLogic.maskForCustomHosts(_host);
      final int _numberOfHosts = IPLogic.numberOfHosts(_mask);
      final String _subnetAddress = _lastSubnetAddress;
      final String _broadcastAddress =
          IPLogic.addHostsToAddress(_subnetAddress, _numberOfHosts + 1);
      final String _firstHost = IPLogic.addHostsToAddress(_subnetAddress, 1);
      final String _lastHost =
          IPLogic.addHostsToAddress(_subnetAddress, _numberOfHosts);

      _lastSubnetAddress = IPLogic.addHostsToAddress(_broadcastAddress, 1);

      final isIPContained = IPLogic.isIPContainedIn(
          ip, _subnetAddress, _broadcastAddress, _mask.toString());

      if (!onlyConatainedInIP || (onlyConatainedInIP && isIPContained)) {
        _customSubnetList.add(
          Column(
            children: [
              SubnetItem(
                subnet: i,
                subnetAddress: _subnetAddress,
                broadcastAddress: _broadcastAddress,
                firstHost: _firstHost,
                lastHost: _lastHost,
                numberOfHosts: _numberOfHosts,
                ipisContained: isIPContained,
                mask: _mask,
              ),
              SizedBox(height: space)
            ],
          ),
        );
      }
    }
    return _customSubnetList;
  }
}
