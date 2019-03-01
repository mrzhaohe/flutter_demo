import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _usrnameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();

  //两种监听文字方式
//  1.initState
//  2.onChanged

  @override
  void initState() {
    _usrnameController.addListener(() {
      print(_usrnameController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('输入框'),
      ),
    
      body: new Center(
        Theme(
          data: Theme.of(context).copyWith(
            hintColor: Colors.grey[200],
            inputDecorationTheme: InputDecorationTheme(
                labelStyle: TextStyle(color: Colors.grey),
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 14.0,
                )),
          ),
          child: new Column(
            children: <Widget>[
              new TextField (
                controller: _usrnameController,
                autofocus: true,
                decoration: InputDecoration(
                    labelText: 'username',
                    hintText: '用户名或邮箱',
                    prefixIcon: Icon(Icons.person)),
//              onChanged: (value){
//                print("onChange:$value");
//              },
              ),
              new TextField(
                decoration: InputDecoration(
                    labelText: 'password',
                    hintText: '您的登录密码',
                    hintStyle: TextStyle(color: Colors.red, fontSize: 11.0),
                    prefixIcon: Icon(Icons.lock)),
                obscureText: true,
                controller: _pwdController,
                onChanged: (value) {
                  print("onChange:$value");
                },
              ),
              // new FocusTestRoute(),
            ],
          ),
        ),
      ),
    );
  }
}

class FocusTestRoute extends StatefulWidget {
  _FocusTestRouteState createState() => _FocusTestRouteState();
}

class _FocusTestRouteState extends State<FocusTestRoute> {
  FocusNode focusNode1 = new FocusNode();

  FocusNode focusNode2 = new FocusNode();

  FocusScopeNode focusScopeNode;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          TextField(
            autofocus: true,
            focusNode: focusNode1,
            decoration: InputDecoration(
              labelText: 'label1',
            ),
          ),
          TextField(
            decoration: InputDecoration(
                labelText: 'label',
                border: UnderlineInputBorder(
                  //下面的代码没有效果
                  borderSide: BorderSide(color: Colors.red, width: 20.0),
                ),
                prefixIcon: Icon(Icons.person)),
            focusNode: focusNode2,
          ),
          Builder(builder: (ctx) {
            return Column(
              children: <Widget>[
                FlatButton(
                  child: Text('移动焦点'),
                  onPressed: () {
                    if (focusScopeNode == null) {
                      focusScopeNode = FocusScope.of(context);
                    }
                    focusScopeNode.requestFocus(focusNode2);
                  },
                ),
                FlatButton(
                  child: Text('隐藏键盘'),
                  onPressed: () {
                    focusNode1.unfocus();
                    focusNode2.unfocus();
                  },
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
