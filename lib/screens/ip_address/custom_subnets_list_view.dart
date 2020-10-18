import 'package:flutter/material.dart';
import 'package:sieci/main.dart';
import 'package:sieci/screens/ip_address/ip_logic.dart';
import 'package:sieci/screens/ip_address/subnet_item.dart';
import 'package:provider/provider.dart';

class CustomSubnetsListView extends StatelessWidget {
  final String ip, subnetMask;
  final bool onlyConatainedInIP;
  static String lastSubnetAddress;

  const CustomSubnetsListView(
      {Key key, this.ip, this.subnetMask, this.onlyConatainedInIP})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    List<String> _hosts = context.watch<CustomHosts>().hosts;
    _hosts.sort((f, s) => int.tryParse(s).compareTo(int.tryParse(f)));

    final String firstSubnetAddress =
        IPLogic.firstSubnetAddress(ip, subnetMask);
    lastSubnetAddress = firstSubnetAddress;

    final String freeHosts =
        IPLogic.maxUsableHosts(int.tryParse(subnetMask)).toString();

    final int usedHosts = IPLogic.usedHosts(_hosts);
    final int leftFreeHosts =
        IPLogic.maxUsableHosts(int.tryParse(subnetMask)) - usedHosts;

    return SizedBox(
      height: size.height / 1.56 - 1,
      width: size.width / 1.2,
      child: ListView.builder(
        itemCount: _hosts.length,
        itemBuilder: (buildContext, val) {
          final String _host = _hosts[val];
          final int _mask = IPLogic.maskForCustomHosts(_host);
          final int _numberOfHosts = IPLogic.numberOfHosts(_mask);
          final String _subnetAddress = lastSubnetAddress;
          final String _broadcastAddress =
              IPLogic.addHostsToAddress(_subnetAddress, _numberOfHosts + 1);
          final String _firstHost =
              IPLogic.addHostsToAddress(_subnetAddress, 1);
          final String _lastHost =
              IPLogic.addHostsToAddress(_subnetAddress, _numberOfHosts);

          lastSubnetAddress = IPLogic.addHostsToAddress(_broadcastAddress, 1);

          final isIPContained = IPLogic.isIPContainedIn(
              ip, _subnetAddress, _broadcastAddress, _mask.toString());

          return (!onlyConatainedInIP || (onlyConatainedInIP && isIPContained))
              ? Column(
                  children: [
                    SubnetItem(
                      subnet: val,
                      subnetAddress: _subnetAddress,
                      broadcastAddress: _broadcastAddress,
                      firstHost: _firstHost,
                      lastHost: _lastHost,
                      numberOfHosts: _numberOfHosts,
                      ipisContained: isIPContained,
                      mask: _mask,
                    ),
                    const SizedBox(height: 15)
                  ],
                )
              : Container();
        },
      ),
    );
  }
}
