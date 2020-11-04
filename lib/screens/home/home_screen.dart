import 'package:flutter/material.dart';
import 'package:sieci/constants.dart';
import 'package:sieci/main.dart';
import 'package:sieci/screens/home/main_drawer.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final Widget child;

  const HomePage({Key key, this.child}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final _appTheme = context.watch<AppTheme>();
    final _style = _appTheme.getStyle();

    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        backgroundColor: _appTheme.getColorBg(),
        title: Text(
          "Informatyka",
          style: _style,
        ),
        actions: [
          ChangeAppThemeButton(),
        ],
      ),
      body: Center(
        child: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [
                  0.1,
                  0.5,
                  0.9,
                ],
                colors: [
                  Colors.black,
                  Colors.blue[900],
                  Colors.black,
                ]),
          ),
          child: widget.child,
        ),
      ),
    );
  }
}

class ChangeAppThemeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _darkTheme = context.watch<AppTheme>().darkTheme;
    return FlatButton.icon(
      icon: Icon(
        Icons.color_lens,
        color: _darkTheme ? white : black,
      ),
      label: Text(
        'Motyw',
        style: _darkTheme ? whiteStyle : blackStyle,
      ),
      onPressed: () => context.read<AppTheme>().changeTheme(),
    );
  }
}
