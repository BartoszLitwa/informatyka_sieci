import 'package:flutter/material.dart';
import 'package:sieci/screens/ip_address/ip_logic.dart';

class SubnetsListView extends StatelessWidget {
  final String ipAddress, subnetMask;

  const SubnetsListView({Key key, this.ipAddress, this.subnetMask})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int subnetMaskOnes = IPLogic.subnetMaskToInt(subnetMask);
    return ListView.builder(
      itemCount: IPLogic.numberOfSubnets(subnetMaskOnes),
      itemBuilder: (buildContext, val) {},
    );
  }
}
