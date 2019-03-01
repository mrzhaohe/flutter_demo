import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/cupertino.dart';
void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext contexr) {
    return new MaterialApp(
      title: 'Route',
      home: new MyHomePage(),

      //注册路由
      routes: {
        "new_page":(context) => NewRoute(),
        "Cupertino_page":(context) => NewCupertinoPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Route demo'),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text('you have pushed this buttom many times:'),
            new Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
            new RaisedButton(
              child: new Text('open new route'),
              color: Colors.lightBlue,
              highlightColor: Colors.blue[700],
              colorBrightness: Brightness.dark,
              splashColor: Colors.grey,
              shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(20.0)),
              textColor: Colors.white,
              onPressed: () {
                // Navigator.push(context,
                //     new MaterialPageRoute(builder: (context) {
                //   return new NewRoute();
                // }));
              
              // 通过路由名打开新路由页
              // 1、在MyApp 类的 Build方法中找到 materialApp,添加 routes属性 然后通过路由名打开新路由页
              // 2、但路由需要参数时，使用命名路由则不够灵活。
              Navigator.pushNamed(context, "new_page");
              },
            ),
            new RandomWordsWidget(),
            new CupertinoButton(
              color: CupertinoColors.activeBlue,
              child: Text('Press'),
              onPressed: (){
                Navigator.pushNamed(context, "Cupertino_page");
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'increment',
        child: new Icon(Icons.add),
      ),
    );
  }
}
//新的路由页面
class NewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: Text('New route'),
      ),
      body: Center(
        child: Text('this is new route'),
      ),
    );
  }
}
// Cupertino widget
class NewCupertinoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold (
      navigationBar: CupertinoNavigationBar(
        middle: Text('Cupertino demo'),
      ),
      child: Center(
        child: CupertinoButton(
          color: CupertinoColors.activeBlue,
          child: new Text('press'),
          onPressed: (){},
        ),
      ),
    );
  }

}


class RandomWordsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wordPair = new WordPair.random();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Text(wordPair.toString()),
    );
  }
}