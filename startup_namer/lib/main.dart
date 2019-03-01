import 'package:flutter/material.dart';

void main() => runApp(startup_number());
class startup_number extends StatelessWidget {
@override
Widget build(BuildContext context) {
  return MaterialApp(
    title: 'Welcome to Flutter',
    home: Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: Center(
        child: Text('hello fluer'),
      ),
    ),
  );
}
}