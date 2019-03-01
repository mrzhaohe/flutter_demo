import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:demo_layout/model/HomeModel.dart';
import 'package:demo_layout/common/WebViewPage.dart';

class HomePageView extends StatefulWidget {
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  List<dynamic> dataList = [];
  @override
  void initState() {
    super.initState();
    loadMoreHomeData();
  }

  loadMoreHomeData() async {
    String jsonStr =
        await DefaultAssetBundle.of(context).loadString('json/HomeData.json');
    HomeModel model = HomeModel.fromJson(json.decode(jsonStr));
    setState(() {
      List<dynamic> data = [];
      data.addAll(model.datas);
      dataList.addAll(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      itemCount: dataList.length,
      itemBuilder: (context, index) {
        return _pageViewTile(dataList[index], index, context);
      },
    );
  }

  Widget _pageViewTile(Datas data, int index, BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
          return CommonWebView(post_id: data.id, url: data.html5);
        }));
      },
      child: Column(
        children: <Widget>[
          new Image.network(
            data.thumbnail,
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width / 2,
          ),
          new Container(
            width: 120.0,
            height: 30.0,
            color: Colors.orange,
            child: Center(
              child: Text(
                'TO READ',
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
            ),
          ),
          new Padding(
            padding: EdgeInsets.only(top: 60),
            child: Text(
              data.title,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
          new Padding(
              padding: EdgeInsets.only(top: 60),
              child: Container(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: Text(
                  data.excerpt,
                  // textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.black, fontSize: 15),
                  // maxLines: 3,
                  // overflow: TextOverflow.ellipsis, //...结尾
                ),
              )),
          new Padding(
            padding: EdgeInsets.only(top: 50),
            child: Container(
              width: 200,
              child: Center(
                child: Divider(
                  height: 1.0,
                  color: Colors.black45,
                ),
              ),
            ),
          ),
          new Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 20),
              child: BottomLikeWidget(
                data: data,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class BottomLikeWidget extends StatefulWidget {
  Datas data;
  BottomLikeWidget({Key key, @required this.data}) : super(key: key);
  @override
  _BottomLikeWidgetState createState() => _BottomLikeWidgetState();
}

class _BottomLikeWidgetState extends State<BottomLikeWidget> {
  bool _isLike = false;
  _toLike() {
    setState(() {
      if (_isLike == false) {
        _isLike = true;
      } else {
        _isLike = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        new Expanded(
          child: new Row(
            children: <Widget>[
              new IconButton(
                padding: EdgeInsets.only(left: 15),
                icon: Image.asset('assets/comment@2x.png'),
                onPressed: () {},
              ),
              new Text(widget.data.comment,
                  style: TextStyle(color: Colors.red, fontSize: 16)),
              new IconButton(
                icon: _isLike
                    ? Image.asset('assets/liked@2x.png')
                    : Image.asset('assets/like@2x.png'),
                onPressed: () {
                  _toLike();
                },
              ),
              new Text(widget.data.good,
                  style: TextStyle(color: Colors.red, fontSize: 16)),
            ],
          ),
        ),
        new Container(
          padding: EdgeInsets.only(right: 15),
          child: Text('阅读数 ${widget.data.view}',
              style: TextStyle(color: Colors.black, fontSize: 16)),
        )
      ],
    );
  }
}
