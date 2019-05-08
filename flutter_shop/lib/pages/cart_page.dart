import 'package:flutter/material.dart';
import '../provide/cart.dart';
import 'package:provide/provide.dart';

import './cart_page/cart_item.dart';
import './cart_page/cart_bottom.dart';

class ShoppingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('购物车'),
        ),
        body: FutureBuilder(
          builder: (context, snapshot) {
            List cartList = Provide.value<CartProvide>(context).cartList;

            if (snapshot.hasData) {
              return Stack(
                children: <Widget>[
                  ListView.builder(
                    itemCount: cartList.length,
                    itemBuilder: (context, index) {
                      // return ListTile(
                      //   title: Text(
                      //       '${cartList[index].goodsName},${cartList[index].count}'),
                      // );
                      return CartItem(cartList[index]);
                    },
                  ),
                  Positioned(
                    left: 0,
                    bottom: 0,
                    child: CartBottom(),
                  )
                ],
              );
            } else {
              return Text('正在加载');
            }
          },
          future: _getCartInfo(context),
        ));
  }

  Future<String> _getCartInfo(BuildContext context) async {
    await Provide.value<CartProvide>(context).getCardInfo();
    return 'end';
  }
}
