import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'widget',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Row&Column'),
        ),
        body: new Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          // children: <Widget>[
          //   Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: <Widget>[
          //       Text('Hello'),
          //       Text('Flutter'),
          //     ],
          //   ),
          //   Row(
          //     mainAxisSize: MainAxisSize.min,
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: <Widget>[
          //       Text('Hello'),
          //       Text('Flutter'),
          //     ],
          //   ),
          //   Row(
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     textDirection: TextDirection.rtl,
          //     children: <Widget>[
          //       Text('Hello'),
          //       Text('Flutter'),
          //     ],
          //   ),
          //   Row(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     verticalDirection: VerticalDirection.down,
          //     children: <Widget>[
          //       Text('Hello',style: TextStyle(fontSize: 30.0),),
          //       Text('Flutter'),
          //     ],
          //   ),
          // ],

          children: <Widget>[
            Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 30.0,
                    color: Colors.red,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 30.0,
                    color: Colors.lightBlue,
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 200.0),
              child: SizedBox(
                height: 100.0,
                child: Flex(
                  direction: Axis.vertical,
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 30.0,
                        color: Colors.red,
                      ),
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 30.0,
                        color: Colors.green,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
