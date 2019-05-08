import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/cartInfo.dart';

import 'package:provide/provide.dart';

import '../../provide/cart.dart';

class CartCounter extends StatelessWidget {
  CartInfo cartInfo;
  CartCounter(this.cartInfo);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(165),
      margin: EdgeInsets.only(top: 5.0),
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: Colors.black12),
      ),
      child: Row(
        children: <Widget>[_reduceBtn(context), _count(), _addBtn(context)],
      ),
    );
  }

  Widget _reduceBtn(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: ScreenUtil().setWidth(45),
      height: ScreenUtil().setHeight(45),
      decoration: BoxDecoration(
          color: cartInfo.count > 1 ? Colors.white : Colors.black12,
          border: Border(right: BorderSide(width: 1.0, color: Colors.black12))),
      child: InkWell(
        child: Text('-'),
        onTap: () {
          Provide.value<CartProvide>(context)
              .reduceOrAddGoodsCount(cartInfo, 'reduce');
        },
      ),
    );
  }

  Widget _count() {
    return Container(
      alignment: Alignment.center,
      width: ScreenUtil().setWidth(70),
      height: ScreenUtil().setHeight(45),
      child: Text('${cartInfo.count.toString()}'),
    );
  }

  Widget _addBtn(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: ScreenUtil().setWidth(45),
      height: ScreenUtil().setHeight(45),
      decoration: BoxDecoration(
          border: Border(left: BorderSide(width: 1.0, color: Colors.black12))),
      child: InkWell(
        child: Text('+'),
        onTap: () {
          Provide.value<CartProvide>(context)
              .reduceOrAddGoodsCount(cartInfo, 'add');
        },
      ),
    );
  }
}
