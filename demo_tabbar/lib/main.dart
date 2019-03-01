import 'package:flutter/material.dart';

//拿到目标 statefulWidget对象 state 的方法：
// 1）Scaffold.of(context).openDrawer();
// 2)借助 globalkey 来获取

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  MyAppState createState() => new MyAppState();
}

class MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {

  int _selectedIndex = 0;
  TabController _tabController;
  List tabs = ['News', 'History', 'Pic'];
  //定义一个globalKey, 由于GlobalKey要保持全局唯一性，我们使用静态变量存储
  
  static GlobalKey<ScaffoldState> _globalkey = new GlobalKey();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return MaterialApp(
      title: 'SSSS',
      home: Scaffold(
        key: _globalkey, //设置key
        appBar: AppBar(
          title: Text('AppBar'),
          //如果给Scaffold添加了抽屉菜单，默认情况下Scaffold会自动将AppBar的leading设置为菜单按钮
          leading: Builder(builder: (context) {
            return IconButton(
              icon: Icon(Icons.dashboard, color: Colors.white),
              onPressed: () {
                // Scaffold.of(context).openDrawer();
                _globalkey.currentState.openDrawer();
              },
            );
          }),

          bottom: TabBar(
              controller: _tabController,
              tabs: tabs.map((e) => Tab(text: e)).toList()),

          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.share),
              onPressed: () {
                _clickRightItem();
              },
            )
          ],
        ),
        //抽屉
        drawer: new Drawer(),

        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home), title: Text('Home')),
            BottomNavigationBarItem(
                icon: Icon(Icons.message), title: Text('Message')),
            BottomNavigationBarItem(
                icon: Icon(Icons.school), title: Text('School')),
          ],
          currentIndex: _selectedIndex,
          onTap: _selectItem,
        ),

        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: _onAdd,
        ),
      ),
    );
  }

  void _selectItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _clickRightItem() {
    print('click right item');
  }

  void _onAdd() {
    print('click add');
  }
}
