import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() => runApp(new SampleApp());

class SampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sample App',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: SampleAppPage(),
    );
  }
}

class SampleAppPage extends StatefulWidget {
  SampleAppPage({Key key}) : super(key: key);
  @override
  _SampleAppPageState createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
  
  bool toggle = true;
  void _toggle() {
    setState(() {
        toggle = !toggle;
    });
  }

  _getToggleChild() {
    if(toggle) {
      return Text('Toggle One');
    } else {
      return CupertinoButton(
        onPressed:(){},
        child: Text('Toggle Two'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: Text('Sample App'),
      ),
      body: Center(
        child: _getToggleChild(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggle,
        // tooltip: 'update text',
        child: Icon(Icons.update),
      ),
    );
  }


}
