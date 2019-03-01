import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new DemoApp());

class DemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Demo',
      home: new RandomWords(),
      theme: new ThemeData(
        primaryColor: Colors.orange
      ),
    );
  }
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = List.generate(20, (i) => WordPair.random()).toList();
  // final _suggestions = generateWordPairs().take(20);
  // _suggestions.addAll(generateWordPairs().take(20));
  final _biggerFont = const TextStyle(fontSize: 18.0, color: Colors.lightBlue);
  final _saved = new Set<WordPair>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          actions: <Widget>[
            new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved)
          ],
          title: new Text('嘿嘿嘿',
              style: const TextStyle(
                  fontSize: 18.0, color: Color.fromRGBO(150, 22, 123, 1.0))),
        ),
        body: _buildSuggestions());
  }

   void _pushSaved() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      //便利以保存的单词 创建tile 或者叫(cell,item)
      final tiles = _saved.map((pair) {
        return new ListTile(
          title: new Text(
            pair.asPascalCase,
            style: _biggerFont,
          ),
        );
      });
      final divided =
          ListTile.divideTiles(context: context, tiles: tiles).toList();
          //返回一个新页面
      return new Scaffold(
        appBar: new AppBar(
          title: new Text('saved Suggestions'),
        ),
        body: new ListView(children: divided),
      );
    }));
  }

  Widget _buildSuggestions() {
    return new ListView.separated(
      padding: const EdgeInsets.all(16.0),
      itemCount: _suggestions.length,
      itemBuilder: (context, index) {
        return _buildRow(_suggestions[index]);
      },
      separatorBuilder: (BuildContext context, int index) {
        return new Divider();
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);
    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      subtitle: new Text('哈哈'),
      trailing: new Icon(alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: alreadySaved ? Colors.red : null),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }
}

class RandomWords extends StatefulWidget {
//如果需要传递参数
  // RandomWord({Key key, @required this.title}) : super(key: key);
  // final String title;
  @override
  RandomWordsState createState() => new RandomWordsState();
}
