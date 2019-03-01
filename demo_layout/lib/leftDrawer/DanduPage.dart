import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:demo_layout/model/DanduWenModel.dart';

class DanduPage extends StatefulWidget {
  _DanduPageState createState() => _DanduPageState();
}

class _DanduPageState extends State<DanduPage> {
  List<dynamic> dataList = [];
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    String jsonStr = await DefaultAssetBundle.of(context).loadString('json/DanduwenData.json');
    DanduWendModel model = DanduWendModel.fromJson(json.decode(jsonStr));
    setState(() {
      List<dynamic>data = [];
      data.addAll(model.datas);
      dataList.addAll(data);//给数据源赋值
    });
  }

  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
        itemCount: dataList.length,
        itemBuilder: (context, index) {
          return danduWenList(dataList[index],context, index);
        },
      ),
    );
  }

  Widget danduWenList(Datas data,BuildContext context, int index) {
    return InkWell(
      child: Stack(
        children: <Widget>[
          new Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 0),
            child: Image.network(
                data.thumbnail,fit: BoxFit.fitHeight,),
          ),
          new Column(
            children: <Widget>[
              new Container(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 80),
                  child: new Center(
                    child: Text(
                      data.title,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  )),
              new Container(
                  padding: EdgeInsets.only(top: 5),
                  child: new Center(
                    child: Text(data.updateTime,
                        style: TextStyle(color: Colors.white70, fontSize: 13)),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
