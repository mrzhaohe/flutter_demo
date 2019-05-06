import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../../provide/detail_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsTopArea extends StatelessWidget {
  const DetailsTopArea({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provide<GoodsDetailInfoProvide>(builder: (context, child, data) {
      var goodsInfo = Provide.value<GoodsDetailInfoProvide>(context)
          .goodsModel
          .data
          .goodInfo;
      if (goodsInfo != null) {
        return Container(
          color: Colors.white,
          padding: EdgeInsets.all(2.0),
          child: Column(
            children: <Widget>[
              _goodsImg(goodsInfo.image1),
              _goodsName(goodsInfo.goodsName),
              _goodsNum(goodsInfo.goodsSerialNumber),
              _goodsPrice(goodsInfo.presentPrice, goodsInfo.oriPrice),
            ],
          ),
        );
      } else {
        return Text('加载中');
      }
    });
  }

  Widget _goodsImg(url) {
    return Image.network(url, width: ScreenUtil().setWidth(740));
  }

  Widget _goodsName(name) {
    return Container(
      width: ScreenUtil().setWidth(730),
      padding: EdgeInsets.only(left: 15.0),
      child: Text(
        name,
        maxLines: 1,
        style: TextStyle(fontSize: ScreenUtil().setSp(30)),
      ),
    );
  }

  Widget _goodsNum(specialnum) {
    return Container(
      width: ScreenUtil().setWidth(730),
      padding: EdgeInsets.only(left: 15.0),
      margin: EdgeInsets.only(top: 8.0),
      child: Text('编号：${specialnum}', style: TextStyle(color: Colors.black26)),
    );
  }

  Widget _goodsPrice(double presentPrice, double oriPrice) {
    return Container(
      width: ScreenUtil().setWidth(730),
      padding: EdgeInsets.only(left: 15.0),
      margin: EdgeInsets.only(top: 8.0),
      child: Row(
        children: <Widget>[
          Text(
            '￥${presentPrice.toString()}',
            style:
                TextStyle(color: Colors.pink, fontSize: ScreenUtil().setSp(30)),
          ),
          Text(
            '市场价：${oriPrice.toString()}',
            style: TextStyle(
              color: Colors.black26,
              decoration: TextDecoration.lineThrough,
              fontSize: ScreenUtil().setSp(26),
            ),
          )
        ],
      ),
    );
  }
}
