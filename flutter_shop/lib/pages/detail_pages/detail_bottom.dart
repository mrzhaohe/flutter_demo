import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailBottom extends StatelessWidget {
  const DetailBottom({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double bottomheight = ScreenUtil().setHeight(100);
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
            child: Container(
              alignment: Alignment.center,
              width: ScreenUtil().setWidth(320),
              height: bottomheight,
              child: Text(
                '立即购买',
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
