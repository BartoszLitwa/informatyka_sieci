import 'package:flutter/material.dart';
import 'package:sieci/constants.dart';

class SubnetItem extends StatelessWidget {
  final String subnetAddress, broadcastAddress, firstHost, lastHost;
  final int numberOfHosts, subnet;
  final bool ipisContained;

  const SubnetItem(
      {Key key,
      this.subnet,
      this.subnetAddress,
      this.broadcastAddress,
      this.firstHost,
      this.lastHost,
      this.numberOfHosts,
      this.ipisContained})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: ipisContained ? green : white,
      ),
      child: Column(
        children: [
          const SizedBox(height: 5),
          Center(
              child: Text('Podsieć ${subnet + 1}',
                  style: TextStyle(
                      color: black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold))),
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
    return Container(
      padding: const EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          icon != null
              ? Icon(icon)
              : Text('$title: ', style: TextStyle(color: black)),
          const SizedBox(width: 5),
          Text(text, style: TextStyle(color: black)),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
