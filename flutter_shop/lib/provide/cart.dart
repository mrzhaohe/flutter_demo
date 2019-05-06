import 'package:flutter/material.dart';
import '../model/goodsDetail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CartProvide with ChangeNotifier {
  String cartString;
  List<Map> tempList;

  save(GoodInfo goodsInfo) async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    cartString = sp.getString('cartInfo');

    var temp = cartString == null ? [] : json.decode(cartString.toString());
    //把获得的值转变为 list
    tempList = (temp as List).cast();
    var isHave = false;
    int index = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == goodsInfo.goodsId) {
        tempList[index]['count'] = item['count'] + 1;
        isHave = true;
      }
      index++;
    });

    if (!isHave) {
      tempList.add({
        'goodsId': goodsInfo.goodsId,
        'goodsName': goodsInfo.goodsName,
        'count': 1,
        'price': goodsInfo.presentPrice,
        'images': goodsInfo.image1
      });
    }
    notifyListeners();
  }

  remove() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('cartInfo');
    notifyListeners();
  }
}
