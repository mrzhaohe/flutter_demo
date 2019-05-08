import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../model/cartInfo.dart';

class CartItem extends StatelessWidget {
  final CartInfo cartInfo;
  CartItem(this.cartInfo);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(5, 15, 5, 15),
      margin: EdgeInsets.fromLTRB(5, 2, 5, 2),
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 1.0, color: Colors.black12))),
      child: Row(
        children: <Widget>[
          _selectedBox(),
          _goodsImg(),
          _goodsName(),
          _goodsPrice()
        ],
      ),
    );
  }

  Widget _selectedBox() {
    return Container(
      margin: EdgeInsets.only(left: 20.0),
      alignment: Alignment.center,
      width: ScreenUtil().setWidth(20),
      child: Checkbox(
        value: true,
        tristate: true,
        activeColor: Colors.pink,
        onChanged: (bool val) {},
      ),
    );
  }

  Widget _goodsImg() {
    return Container(
        margin: EdgeInsets.only(left: 20.0, top: 10.0),
        padding: EdgeInsets.all(3.0),
        width: ScreenUtil().setWidth(150),
        decoration: BoxDecoration(
            border: Border.all(width: 1.0, color: Colors.black12)),
        child: Image.network(cartInfo.images));
  }

  Widget _goodsName() {
    return Container(
        width: ScreenUtil().setWidth(300),
        alignment: Alignment.topLeft,
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Text(cartInfo.goodsName),
          ],
        ));
  }

  Widget _goodsPrice() {
    return Container(
      width: ScreenUtil().setWidth(150),
      alignment: Alignment.centerRight,
      child: Column(
        children: <Widget>[
          Text('￥${cartInfo.price}'),
          Container(
            child: InkWell(
              onTap: () {},
              child:
                  Icon(Icons.delete_forever, color: Colors.black26, size: 30),
            ),
          )
        ],
      ),
    );
  }
}
