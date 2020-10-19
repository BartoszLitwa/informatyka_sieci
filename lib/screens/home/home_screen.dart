import 'package:flutter/material.dart';
import 'package:sieci/screens/home/main_drawer.dart';

class HomePage extends StatefulWidget {
  final Widget child;

  const HomePage({Key key, this.child}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text("Informatyka"),
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
