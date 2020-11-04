import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:sieci/constants.dart';
import 'package:sieci/main.dart';
import 'package:sieci/screens/ip_address/ip_logic.dart';

class DataTableCustomHosts extends StatelessWidget {
  const DataTableCustomHosts({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomHosts hosts = context.watch<CustomHosts>();
    final _appTheme = context.watch<AppTheme>();
    final _style = _appTheme.getStyle();

    final listOfRows = _dataToRows(hosts, _style);
    final double fontSize =
        listOfRows.length > 9 ? (16.0 - (listOfRows.length - 9.0)) : 16.0;
    return SizedBox(
      height: _appTheme.height / 2.85,
      child: DataTable(
        dataTextStyle: blackStyle.copyWith(fontSize: normalFontSize),
        headingTextStyle: blackStyle.copyWith(fontSize: bigFontSize),
        columnSpacing: _appTheme.width / 10,
        dataRowHeight: fontSize * 1.5,
        sortAscending: true,
        columns: <DataColumn>[
          DataColumn(label: Text('Hostów', style: _style)),
          DataColumn(label: Text('Max', style: _style)),
          DataColumn(label: Text('Maska', style: _style)),
          DataColumn(label: Text('Usuń', style: _style)),
        ],
        rows: listOfRows,
      ),
    );
  }

  List<DataRow> _dataToRows(CustomHosts customHosts, TextStyle style) {
    List<DataRow> result = new List<DataRow>();
    for (var i = 0; i < customHosts.hosts.length; i++) {
      result.add(DataRow(cells: <DataCell>[
        DataCell(
          Center(
            child: Text(
              customHosts.hosts[i],
              style: style,
            ),
          ),
        ),
        DataCell(
          Center(
            child: Text(
              IPLogic.maxHostsForCustomHosts(customHosts.hosts[i]).toString(),
              style: style,
            ),
          ),
        ),
        DataCell(
          Center(
            child: Text(
              '/${IPLogic.maskForCustomHosts(customHosts.hosts[i])}'.toString(),
              style: style,
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
