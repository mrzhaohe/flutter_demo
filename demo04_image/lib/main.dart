import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'home',
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Icon_demo'),
      ),
      body: new Center(
        child: new Column(
          children: <Image>[
            new Image(
              image: NetworkImage(
                  'https://avatars2.githubusercontent.com/u/20411648?s=460&v=4'),
              width: 100.0,
            ),
            Image.network(
              'https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=1029543231,3186068207&fm=85&app=63&f=JPEG?w=121&h=75&s=27067A234E92D5A30A78B5C30100A0B2',
              width: 100,
              height: 100,
              alignment: Alignment.centerRight,
//              repeat: ImageRepeat.repeatY,
              fit: BoxFit.contain,
              colorBlendMode: BlendMode.difference,
            ),

          ],
        ),
      ),
    );
  }
}
