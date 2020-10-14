import 'package:flutter/material.dart';
import 'package:sieci/constants.dart';

class AdditionalSettingsBottomSheet extends StatefulWidget {
  @override
  _AdditionalSettingsBottomSheetState createState() =>
      _AdditionalSettingsBottomSheetState();
}

class _AdditionalSettingsBottomSheetState
    extends State<AdditionalSettingsBottomSheet> {
  List<String> _customNumberOfHosts;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox.expand(
      child: DraggableScrollableSheet(
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 15),
            color: white,
            height: size.height / 2,
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
                        Navigator.popAndPushNamed(context, '/ipAddressScreen',
                            result: _customNumberOfHosts);
                      },
                      child: Icon(Icons.exit_to_app),
                    )
                  ],
                ),
                Container(
                  color: Colors.blue[100],
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: 25,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(title: Text('Item $index'));
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
