import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../provide/cart.dart';
import 'package:provide/provide.dart';

import '../../provide/detail_info.dart';
import '../../provide/currentIndex.dart';

class DetailBottom extends StatelessWidget {
  const DetailBottom({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double bottomheight = ScreenUtil().setHeight(100);

    return Container(
      width: ScreenUtil().setWidth(750),
      height: bottomheight,
      color: Colors.white,
      child: Row(children: <Widget>[
        Stack(
          children: <Widget>[
            InkWell(
                onTap: () {
                  Provide.value<CurrentIndexProvide>(context).changeIndex(2);
                  Navigator.pop(context);
                },
                child: Container(
                  width: ScreenUtil().setWidth(110),
                  height: bottomheight,
                  child: Icon(Icons.shopping_cart, size: 35, color: Colors.red),
                )),
            Provide<CartProvide>(
              builder: (context, child, data) {
                int goodsCount =
                    Provide.value<CartProvide>(context).allGoodsCount;
                return Positioned(
                  top: 0,
                  right: 10,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(6, 3, 6, 3),
                    decoration: BoxDecoration(
                      color: Colors.pink,
                      border: Border.all(width: 2, color: Colors.white),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Text('${goodsCount}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenUtil().setSp(22))),
                  ),
                );
              },
            ),
          ],
        ),
        InkWell(
          onTap: () {
            var goodsInfo = Provide.value<GoodsDetailInfoProvide>(context)
                .goodsModel
                .data
                .goodInfo;
            print(goodsInfo.goodsName);
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
      ]),
    );
  }
}
