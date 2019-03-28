/*
 * @Author: 赵贺 
 * @Date: 2019-03-09 16:29:01 
 * @Last Modified by: 赵贺
 * @Last Modified time: 2019-03-09 16:29:57
 */
import 'package:flutter/material.dart';
import './expansion.dart';
import './expandlist.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final Widget child;

  MyApp({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo',
      theme: ThemeData.dark(),
      // home: ExpansionTileDemo(),
      home: ExpandListDemo(),
    );
  }
}
