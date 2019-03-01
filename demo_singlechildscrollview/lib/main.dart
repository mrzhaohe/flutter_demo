import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
// import 'package:fluro/fluro.dart';
// import 'package:flutter/rendering.dart';

import './listviewdemolist.dart';
// import './infinitelistview.dart';
// import './routes.dart';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'sss',
      home: Scaffold(
        appBar: AppBar(
          title: Text('滚动列表'),
        ),
        body: Center(
          // child: SingleChildScrollViewTestRoute(),
          child: InfiniteListView(),
        ),
      ),
    );
  }
}

class InfiniteListView extends StatefulWidget {
  @override
  _InfiniteListViewState createState() => new _InfiniteListViewState();
}

class _InfiniteListViewState extends State<InfiniteListView> {
  static const loadingTag = "##loading##"; //表尾标记
  var _words = <String>[loadingTag];

  @override
  void initState() {
    _retrieveData();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: _words.length,
      itemBuilder: (context, index) {
        //如果到了表尾
        if (_words[index] == loadingTag) {
          //不足100条，继续获取数据
          if (_words.length - 1 < 100) {
            //获取数据
            _retrieveData();
            //加载时显示loading
            return Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child: SizedBox(
                  width: 24.0,
                  height: 24.0,
                  child: CircularProgressIndicator(strokeWidth: 2.0)
              ),
            );
          } else {
            //已经加载了100条数据，不再获取数据。
            return Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(16.0),
                child: Text("没有更多了", style: TextStyle(color: Colors.grey),)
            );
          }
        }
        //显示单词列表项
        return ListTile(title: Text(_words[index]));
      },
      separatorBuilder: (context, index) => Divider(height: .0),
    );
  }

  void _retrieveData() {
    Future.delayed(Duration(seconds: 2)).then((e) {
      _words.insertAll(_words.length - 1,
          //每次生成20个单词
          generateWordPairs().take(20).map((e) => e.asPascalCase).toList()
      );
      setState(() {
        //重新构建列表
      });
    });
  }

}




class ListView1 extends StatelessWidget {
  List routes = ListViewDemoList().getRoutes();
  @override
  Widget build(BuildContext context) {
    Widget divide1 = Divider(color: Colors.blue, height: 0.5);
    Widget divide2 = Divider(color: Colors.red, height: 0.5);
    return ListView.separated(
      itemCount: routes.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text('${routes[index]}'),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        // new ListView2(title: '${routes[index]}')
                        
                       new InfiniteListView()
                        
                        ));
            print('ssss');
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return index % 2 == 0 ? divide1 : divide2;
      },
    );
  }
}



// class ListView2 extends StatelessWidget {
//   final String title;

//   ListView2({Key key, @required this.title}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Widget divide1 = Divider(color: Colors.blue, height: 0.5);
//     Widget divide2 = Divider(color: Colors.red, height: 0.5);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(this.title),
//       ),
//       body: Center(
//         child: ListView.separated(
//           itemCount: 100,
//           itemBuilder: (BuildContext context, int index) {
//             return ListTile(
//               title: Text('$index'),
//             );
//           },
//           separatorBuilder: (BuildContext context, int index) {
//             return index % 2 == 0 ? divide1 : divide2;
//           },
//         ),
//       ),
//     );
//   }
// }



