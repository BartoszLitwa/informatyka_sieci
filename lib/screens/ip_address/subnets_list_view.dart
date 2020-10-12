import 'package:flutter/material.dart';
import 'package:sieci/screens/ip_address/ip_logic.dart';
import 'package:sieci/screens/ip_address/subnet_item.dart';

class SubnetsListView extends StatelessWidget {
  final String ip, subnetMask;
  final bool onlyConatainedInIP;

  const SubnetsListView(
      {Key key, this.ip, this.subnetMask, this.onlyConatainedInIP})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final int subnetMaskOnes = IPLogic.subnetMaskToInt(subnetMask);
    final String firstSubnetAddress =
        IPLogic.firstSubnetAddress(ip, subnetMask);
    return SizedBox(
      height: size.height / 1.56 - 1,
      width: size.width / 1.2,
      child: ListView.builder(
        itemCount: IPLogic.numberOfSubnets(subnetMaskOnes),
        itemBuilder: (buildContext, val) {
          final mask = subnetMaskOnes.toString();
          final subNet =
              IPLogic.subnetAddress(firstSubnetAddress, mask, subnet: val);
          final broadcast = IPLogic.broadcastAddress(subNet, mask, subnet: val);
          final firstHost = IPLogic.firstHostAddress(subNet, mask);
          final lastHost = IPLogic.lastHostAddress(broadcast, mask);
          final hosts = IPLogic.numberOfHosts(subnetMaskOnes);
          final isIPContained =
              IPLogic.isIPContainedIn(ip, subNet, broadcast, mask);
          return (!onlyConatainedInIP || (onlyConatainedInIP && isIPContained))
              ? Column(
                  children: [
                    SubnetItem(
                      subnet: val,
                      subnetAddress: subNet,
                      broadcastAddress: broadcast,
                      firstHost: firstHost,
                      lastHost: lastHost,
                      numberOfHosts: hosts,
                      ipisContained: isIPContained,
                    ),
                    const SizedBox(height: 15)
                  ],
                )
              : Container(
                  height: 0,
                );
        },
      ),
    );
  }
}
