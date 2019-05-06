import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../../provide/detail_info.dart';

import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var goodsDetail = Provide.value<GoodsDetailInfoProvide>(context)
        .goodsModel
        .data
        .goodInfo
        .goodsDetail;

    return Provide<GoodsDetailInfoProvide>(
      builder: (context, child, data) {
        bool isLeft = Provide.value<GoodsDetailInfoProvide>(context).isLeft;
        if (isLeft) {
          return Container(
            child: Html(
              data: goodsDetail,
            ),
          );
        } else {
          return Container(
            width: ScreenUtil().setWidth(750),
            padding: EdgeInsets.all(10.0),
            margin: EdgeInsets.all(10.0),
            alignment: Alignment.center,
            child: Text('暂时没有评论'),
          );
        }
      },
    );
  }
}