import 'package:flutter/material.dart';

class ExpansionTileDemo extends StatelessWidget {
  final Widget child;

  ExpansionTileDemo({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ss'),
      ),
      body: Center(
        child: ExpansionTile(
          title: Text('tile'),
          leading: Icon(Icons.ac_unit),
          backgroundColor: Colors.white12,
          children: <Widget>[
            ListTile(
              title: Text('list tile'),
              subtitle: Text('sub title'),
            )
          ],
        ),
      ),
    );
  }
}
