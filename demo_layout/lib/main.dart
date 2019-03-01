import 'package:flutter/material.dart';

import 'package:demo_layout/leftDrawer/leftDrawerPage.dart';
import 'package:demo_layout/HomePage.dart';

void main() => runApp(
      new MyApp(),
    );

Widget _drawer() => LeftDrawer(
      widthPercent: 1.0,
    );
Widget _enddrawer() => Drawer();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Colors.black),
        home: Scaffold(
            appBar: _appBar,
            drawer: _drawer(),
            endDrawer: _enddrawer(),
            body: new Container(
              child: new HomePageView(),
            )));
  }

  get _appBar => AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  // print('menu menu');
                  Scaffold.of(context).openDrawer();
                });
          },
        ),
        backgroundColor: Colors.black87,
        title: Text(
          '单读',
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  // print('settings');
                  Scaffold.of(context).openEndDrawer();
                },
              );
            },
          ),
        ],
      );
}
