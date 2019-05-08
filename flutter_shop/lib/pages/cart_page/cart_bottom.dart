import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: ScreenUtil().setWidth(750),
        height: ScreenUtil().setHeight(120),
        // color: Colors.black12,
        child: Row(
          children: <Widget>[
            _selectedBox(),
            _desc(),
            _priceItem(9.0),
            _checkIn(3)
          ],
        ));
  }

  Widget _selectedBox() {
    return Container(
      child: Checkbox(
        value: true,
        activeColor: Colors.pink,
        onChanged: (bool val) {},
      ),
    );
  }

  Widget _desc() {
    return Container(
      child: Text('全选'),
    );
  }

  Widget _priceItem(double totalprice) {
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

  Widget _checkIn(int count) {
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
