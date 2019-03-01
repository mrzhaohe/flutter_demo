import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main()=> runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
          title: 'switch',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Switch_demo'),

        ),
        body: new Center(
          child: new SwitchAndCheckBoxRoute(),
        ),
      ),
    );
  }
}


class SwitchAndCheckBoxRoute extends StatefulWidget {
  @override

  _SwitchAndCheckBoxRouteState createState()=> _SwitchAndCheckBoxRouteState();
}

class _SwitchAndCheckBoxRouteState extends State<SwitchAndCheckBoxRoute> {

  bool _switchSelected = true;
  bool _checkboxSelected = true;
  @override
  Widget build(BuildContext context) {

    return new Column(
      children: <Widget>[
        CupertinoSwitch(
            value: _switchSelected,
            onChanged: (value){
              setState(() {
                _switchSelected = value;
              });
            }),
        Checkbox(
          value: _checkboxSelected,
          onChanged: (value){
            setState(() {
              _checkboxSelected = value;
            });
          },
        ),
      ],
    );
  }
}


