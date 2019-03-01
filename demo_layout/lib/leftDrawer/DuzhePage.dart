import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:demo_layout/model/DuzheLunModel.dart';

class DuzhePage extends StatefulWidget {
  _DuzhePageState createState() => _DuzhePageState();
}

class _DuzhePageState extends State<DuzhePage> {
  List<dynamic> dataList = [];

  @override
  void initState() {
    super.initState();
    loadMoreData();
  }

  loadMoreData() async {
    String jsonStr = await DefaultAssetBundle.of(context)
        .loadString('json/DuzhelunData.json');
    DuzheLunModel model = DuzheLunModel.fromJson(json.decode(jsonStr));
    setState(() {
      List<dynamic> data = [];
      data.addAll(model.datas);
      dataList.addAll(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: new ListView.builder(
        itemCount: dataList.length,
        itemBuilder: (context, index) {
          return _duzheLunTile(dataList[index], context, index);
        },
      ),
    );
  }
}

Widget _duzheLunTile(Datas data, BuildContext context, int index) {
  return Column(
    children: <Widget>[
      new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            // padding: EdgeInsets.only(left: 10, top: 10),
            width: 50,
            height: 50,
            child: new ClipOval(
              child: new Image.network(
                data.avatar,
              ),
            ),
            margin: EdgeInsets.only(left: 10, top: 10),
          ),
          new Expanded(
            child: new Container(
              padding: EdgeInsets.only(left: 10, top: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(
                    ///名字
                    data.nickname,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  new Text(data.updateTime,
                      style: TextStyle(color: Colors.black38, fontSize: 12)),
                  new Text(
                    data.content,
                    style: TextStyle(color: Colors.black38, fontSize: 15),
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                  new Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: new Divider(
                      height: 0.3,
                      color: Colors.red,
                      // indent: 100.0,
                    ),
                  ),
                  new Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  new Row(
                    children: <Widget>[
                      new Expanded(
                        child: Text(data.toAuthorName),
                      ),
                      new Container(
                        margin: EdgeInsets.only(right: 10),
                        width: 10,
                        height: 15,
                        child: new Image.asset('assets/indiimg_9x17_@2x.png'),
                      )
                    ],
                  ),
                  new Padding(
                    padding: EdgeInsets.only(bottom: 10),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      new Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: new Divider(
          height: 0.5,
          color: Colors.green,
        ),
      )
    ],
  );
}
