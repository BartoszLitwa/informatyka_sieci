import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:sieci/constants.dart';
import 'package:sieci/main.dart';
import 'package:sieci/screens/ip_address/ip_logic.dart';

class DataTableCustomHosts extends StatelessWidget {
  const DataTableCustomHosts({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final CustomHosts hosts = context.watch<CustomHosts>();

    final listOfRows = _dataToRows(hosts);
    final double fontSize =
        listOfRows.length > 9 ? (16.0 - (listOfRows.length - 9.0)) : 16.0;
    return SizedBox(
      height: size.height / 2.85,
      child: DataTable(
        dataTextStyle: blackStyle.copyWith(fontSize: 16),
        headingTextStyle: blackStyle.copyWith(fontSize: 18),
        columnSpacing: 40,
        dataRowHeight: fontSize * 1.5,
        sortAscending: true,
        columns: const <DataColumn>[
          DataColumn(label: const Text('Hostów', style: blackStyle)),
          DataColumn(label: const Text('Max', style: blackStyle)),
          DataColumn(label: const Text('Maska', style: blackStyle)),
          DataColumn(label: const Text('Usuń', style: blackStyle)),
        ],
        rows: listOfRows,
      ),
    );
  }

  List<DataRow> _dataToRows(CustomHosts customHosts) {
    List<DataRow> result = new List<DataRow>();
    for (var i = 0; i < customHosts.hosts.length; i++) {
      result.add(DataRow(cells: <DataCell>[
        DataCell(
          Center(
            child: Text(
              customHosts.hosts[i],
              style: blackStyle,
            ),
          ),
        ),
        DataCell(
          Center(
            child: Text(
              IPLogic.maxHostsForCustomHosts(customHosts.hosts[i]).toString(),
              style: blackStyle,
            ),
          ),
        ),
        DataCell(
          Center(
            child: Text(
              '/${IPLogic.maskForCustomHosts(customHosts.hosts[i])}'.toString(),
              style: blackStyle,
            ),
          ),
        ),
        DataCell(
          Center(
            child: Icon(
              Icons.cancel,
              color: red,
            ),
          ),
          onTap: () => customHosts.remove(i),
        )
      ]));
    }

    return result;
  }
}
