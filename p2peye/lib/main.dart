import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:p2peye/home.dart';
import 'package:p2peye/bbs.dart';
import 'package:p2peye/message.dart';
import 'package:p2peye/plate.dart';
import 'package:p2peye/mine.dart';

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
      home: MyHomePage(title: '网贷天眼'),
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
  int currentIndex = 0;
  var currentPage;
  final List tabPages = [
    HomePage(),
    BBSPage(),
    MessagePage(),
    PlatePage(),
    MinePage()
  ];

  Image getTabIcon(int index) {
    if (currentIndex == index) {
      return tabImages[index][1];
    } else {
      return tabImages[index][0];
    }
  }

  static Image getTabImage(path) {
    return new Image.asset(path);
  }

  static List tabImages = [
    [
      getTabImage('assets/tabbar_home_background.png'),
      getTabImage('assets/tabbar_home_background_press.png')
    ],
    [
      getTabImage('assets/tabbar_bbs_background.png'),
      getTabImage('assets/tabbar_bbs_background_press.png')
    ],
    [
      getTabImage('assets/tabbar_message_background.png'),
      getTabImage('assets/tabbar_message_background_press.png')
    ],
    [
      getTabImage('assets/tabbar_archives_background.png'),
      getTabImage('assets/tabbar_archives_background_press.png')
    ],
    [
      getTabImage('assets/tabbar_mine_noLogin_background.png'),
      getTabImage('assets/tabbar_mine_noLogin_background_press.png')
    ]
  ];

  @override
  void initState() {
    currentPage = tabPages[currentIndex];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // initData();
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        bottomNavigationBar: CupertinoTabBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: getTabIcon(0), title: Text('首页')),
            BottomNavigationBarItem(icon: getTabIcon(1), title: Text('社区')),
            BottomNavigationBarItem(icon: getTabIcon(2), title: Text('消息')),
            BottomNavigationBarItem(icon: getTabIcon(3), title: Text('档案')),
            BottomNavigationBarItem(icon: getTabIcon(4), title: Text('我的')),
          ],
          currentIndex: currentIndex,
          activeColor: Colors.blue,
          onTap: (index) {
            setState(() {
              currentIndex = index;
              currentPage = tabPages[index];
            });
          },
        ),
        body: currentPage);
  }
}
