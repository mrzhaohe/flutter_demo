import 'package:flutter/material.dart';

import 'package:provide/provide.dart';
import '../provide/counter.dart';

class ShoppingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
      padding: EdgeInsets.only(top: 100),
      child: Column(
        children: <Widget>[
          Provide<Counter>(
            builder: (context, child, counter) {
              return Text('${counter.number}');
            },
          ),
          RaisedButton(
            onPressed: () {
              Provide.value<Counter>(context).increment();
            },
            child: Text('增加'),
          ),
          RaisedButton(
            onPressed: () {
              Provide.value<Counter>(context).decrement();
            },
            child: Text('减少'),
          )
        ],
      ),
    )));
  }
}
