import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../provide/detail_info.dart';

class DetailTabBar extends StatelessWidget {
  const DetailTabBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provide<GoodsDetailInfoProvide>(
      builder: (context, child, data) {
        bool isLeft = Provide.value<GoodsDetailInfoProvide>(context).isLeft;
        bool isRight = Provide.value<GoodsDetailInfoProvide>(context).isRight;
        return Container(
            margin: EdgeInsets.only(top: 15.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    _myTabBarLeft(context, isLeft),
                    _myTabBarRight(context, isRight)
                  ],
                ),
              ],
            ));
      },
    );
  }

  Widget _myTabBarLeft(BuildContext context, bool isLeft) {
    return InkWell(
      onTap: () {
        Provide.value<GoodsDetailInfoProvide>(context)
            .changeLeftAndRight('Left');
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        width: ScreenUtil().setWidth(375),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 1.0, color: isLeft ? Colors.pink : Colors.black12))),
        child: Text('详情',
            style: TextStyle(color: isLeft ? Colors.pink : Colors.black)),
      ),
    );
  }

  Widget _myTabBarRight(BuildContext context, bool isRight) {
    return InkWell(
      onTap: () {
        Provide.value<GoodsDetailInfoProvide>(context)
            .changeLeftAndRight('Right');
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(375),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 1.0,
                    color: isRight ? Colors.pink : Colors.black12))),
        child: Text('评论',
            style: TextStyle(color: isRight ? Colors.pink : Colors.black)),
      ),
    );
  }
}
