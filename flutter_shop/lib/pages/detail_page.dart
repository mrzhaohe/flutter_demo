import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/detail_info.dart';

class DetailsPage extends StatelessWidget {
  final String goodsId;
  DetailsPage(this.goodsId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            print('back');
            Navigator.pop(context);
          },
        ),
        title: Text('商品详情页'),
      ),
      body: FutureBuilder(
        future: _getInfo(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Container(
              child: Column(
                children: <Widget>[],
              ),
            );
          } else {
            return Text('loading');
          }
        },
      ),
    );
  }

  _getInfo(BuildContext context) async {
    await Provide.value<GoodsDetailInfoProvide>(context).getGoodsInfo(goodsId);
    return '完成加载';
  }
}
