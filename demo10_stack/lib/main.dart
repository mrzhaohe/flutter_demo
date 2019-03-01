import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text('Stack和绝对定位'),
     ),
     body: new Center(
       child: ConstrainedBox(
         constraints: BoxConstraints.expand(),
         child: Stack(
           alignment: Alignment.center,
           children: <Widget>[
             Container(
               child: Text('Hello fluter', style: TextStyle(color: Colors.white),),
               color: Colors.red,
             ),
             Positioned(
               left: 19.0,
               child: Text('I am jack'),
             ),
             Positioned(
               top: 20.0,
               child: Text('your friend'),
             )
           ],
         ),
       ),
     ),
   );
  }
}
