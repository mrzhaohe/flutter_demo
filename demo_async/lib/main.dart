import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(SampleApp());
}

class SampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ss',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SampleAppPage(),
    );
  }
}

class SampleAppPage extends StatefulWidget {
  _SampleAppPageState createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
  
  List widgets = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('sssssss'),
      ),
      body: ListView.builder(
          itemCount: widgets.length,
          itemBuilder: (context, index) {
            return layoutRow(index);
          }),
    );
  }
  //返回cell
  Widget layoutRow(int index) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Text('${widgets[index]['title']}'),
    );
  }
  // 加载数据
  loadData() async {
    String dataURl = 'https://jsonplaceholder.typicode.com/posts';
    http.Response response = await http.get(dataURl);
    setState(() {
      widgets = json.decode(response.body);
    });
  }

}
