import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartCounter extends StatelessWidget {
  final int count;
  CartCounter(this.count);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(165),
      margin: EdgeInsets.only(top: 5.0),
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: Colors.black12),
      ),
      child: Row(
        children: <Widget>[_reduceBtn(), _count(), _addBtn()],
      ),
    );
  }

  Widget _reduceBtn() {
    return Container(
      alignment: Alignment.center,
      width: ScreenUtil().setWidth(45),
      height: ScreenUtil().setHeight(45),
      decoration: BoxDecoration(
          border: Border(right: BorderSide(width: 1.0, color: Colors.black12))),
      child: InkWell(
        child: Text('-'),
      ),
    );
  }

  Widget _count() {
    return Container(
      alignment: Alignment.center,
      width: ScreenUtil().setWidth(70),
      height: ScreenUtil().setHeight(45),
      child: Text('${count}'),
    );
  }

  Widget _addBtn() {
    return Container(
      alignment: Alignment.center,
      width: ScreenUtil().setWidth(45),
      height: ScreenUtil().setHeight(45),
      decoration: BoxDecoration(
          border: Border(left: BorderSide(width: 1.0, color: Colors.black12))),
      child: InkWell(
        child: Text('+'),
      ),
    );
  }
}
