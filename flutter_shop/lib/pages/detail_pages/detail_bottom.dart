import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../provide/cart.dart';
import 'package:provide/provide.dart';
import '../../model/goodsDetail.dart';

class DetailBottom extends StatelessWidget {
  const DetailBottom({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double bottomheight = ScreenUtil().setHeight(100);

    // int count = 0;
    // if (Provide.value<CartProvide>(context).tempList.length > 0) {
    //   count = Provide.value<CartProvide>(context).tempList.length;
    // }
    return Container(
      width: ScreenUtil().setWidth(750),
      height: bottomheight,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          InkWell(
              child: Container(
            width: ScreenUtil().setWidth(110),
            height: bottomheight,
            child: Icon(Icons.shopping_basket, size: 35, color: Colors.red),
          )),
          InkWell(
            onTap: () {
              var goodsInfo = Provide.value<DetailsGoodsData>(context).goodInfo;
              Provide.value<CartProvide>(context).save(goodsInfo);
            },
            child: Container(
              alignment: Alignment.center,
              width: ScreenUtil().setWidth(320),
              height: bottomheight,
              child: Text(
                '加入购物车',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.green,
            ),
          ),
          InkWell(
            onTap: () {
              Provide.value<CartProvide>(context).remove();
            },
            child: Container(
              alignment: Alignment.center,
              width: ScreenUtil().setWidth(320),
              height: bottomheight,
              child: Text(
                '清空购物车',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}
