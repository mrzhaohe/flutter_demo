import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provide/provide.dart';
import '../../provide/cart.dart';

class CartBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(120),
      decoration: BoxDecoration(
          border: Border(top: BorderSide(width: 1.0, color: Colors.black12))),
      child: Provide<CartProvide>(builder: (context, child, data) {
        return Row(
          children: <Widget>[
            _selectedBox(context),
            _desc(),
            _priceItem(context),
            _checkIn(context)
          ],
        );
      }),
    );
  }

  Widget _selectedBox(BuildContext context) {
    bool isAllSelected = Provide.value<CartProvide>(context).isAllChecked;
    return Container(
      child: Checkbox(
        value: isAllSelected,
        activeColor: Colors.pink,
        onChanged: (bool val) {
          Provide.value<CartProvide>(context).changeAllSelectedState(val);
        },
      ),
    );
  }

  Widget _desc() {
    return Container(
      child: Text('全选'),
    );
  }

  Widget _priceItem(BuildContext context) {
    double totalprice = Provide.value<CartProvide>(context).allPrice;
    return Container(
        width: ScreenUtil().setWidth(430),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(top: 10.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  width: ScreenUtil().setWidth(310),
                  child: Text('合计:',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: ScreenUtil().setSp(26))),
                ),
                Container(
                  width: ScreenUtil().setHeight(120),
                  alignment: Alignment.centerRight,
                  child: Text('￥ ${totalprice}',
                      style: TextStyle(
                          color: Colors.pink,
                          fontSize: ScreenUtil().setSp(26))),
                )
              ],
            ),
            Container(
              width: ScreenUtil().setWidth(430),
              alignment: Alignment.centerRight,
              child: Text(
                '满 10 元免配送费，预购免配送费',
                style: TextStyle(fontSize: ScreenUtil().setSp(23)),
              ),
            ),
          ],
        ));
  }

  Widget _checkIn(BuildContext context) {
    int count = Provide.value<CartProvide>(context).allGoodsCount;
    return Container(
      width: ScreenUtil().setWidth(160),
      height: ScreenUtil().setHeight(80),
      padding: EdgeInsets.only(left: 10),
      child: InkWell(
        child: Container(
          padding: EdgeInsets.all(10.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3.0),
            color: Colors.red,
          ),
          child: Text(
            '结算(${count})',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
