import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class InfiniteListView extends StatefulWidget {
  @override
  _InfiniteListViewState createState() => new _InfiniteListViewState();
}

class _InfiniteListViewState extends State<InfiniteListView> {
  
  static const loadingTag = '##loading##';
  var _words = <String>[loadingTag];

  @override
  void initState() {
    _receiveMoreData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('无限加载'),
      ),
      body: Center(
        child: ListView.separated(
          itemCount: _words.length,
          itemBuilder: (context, index) {
            if (_words[index] == loadingTag) {
              if (_words.length - 1 < 100) {
                _receiveMoreData();
                return Container(
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 20.0,

                    height: 20.0,
                    child: CircularProgressIndicator(strokeWidth: 2.0),
                  ),
                );
              } else {
                return Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'no more data',
                    style: TextStyle(color: Colors.grey),
                  )
                );
              }
            }
            return ListTile(title: Text(_words[index]));
          },
          separatorBuilder: (context, index) => Divider(
                height: 1.0,
              ),
        ),
      ),
    );
  }

  void _receiveMoreData() {
    Future.delayed(Duration(seconds: 1)).then((e) {
      _words.insertAll(_words.length - 1,
          generateWordPairs().take(20).map((e) => e.asPascalCase).toList());
    });
    // setState(() {});
  }
}
