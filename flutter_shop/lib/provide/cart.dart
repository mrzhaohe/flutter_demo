//购物车相关

import 'package:flutter/material.dart';
import '../model/goodsDetail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../model/cartInfo.dart';

class CartProvide with ChangeNotifier {
  String cartString;

  List<CartInfo> cartList;
  int allGoodsCount = 0;
  double allPrice = 0;
  bool isAllChecked = true;

  save(GoodInfo goodsInfo) async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    cartString = sp.getString('cartInfo');

    var temp = cartString == null ? [] : json.decode(cartString.toString());
    //把获得的值转变为 list
    List<Map> tempList = (temp as List).cast();
    var isHave = false;
    int index = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == goodsInfo.goodsId) {
        tempList[index]['count'] = item['count'] + 1;
        cartList[index].count++;
        isHave = true;
      }
      index++;
    });

    if (!isHave) {
      Map<String, dynamic> newGoods = {
        'goodsId': goodsInfo.goodsId,
        'goodsName': goodsInfo.goodsName,
        'count': 1,
        'price': goodsInfo.presentPrice,
        'images': goodsInfo.image1,
        'isChecked': true
      };
      tempList.add(newGoods);
      cartList.add(new CartInfo.fromJson(newGoods));
    }
    cartString = json.encode(tempList).toString();
    print(cartString);
    print(cartString.toString());
    sp.setString('cartInfo', cartString); //持久化

    notifyListeners();
  }

  getCardInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    cartString = sp.getString('cartInfo');

    cartList = [];
    if (cartString == null) {
      cartList = [];
    } else {
      List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
      allGoodsCount = 0;
      allPrice = 0;
      isAllChecked = true;
      tempList.forEach((item) {
        cartList.add((new CartInfo.fromJson(item)));

        if (item['isChecked']) {
          allPrice += item['count'] * item['price'];
          allGoodsCount += item['count'];
        } else {
          isAllChecked = false;
        }
      });
    }
    notifyListeners();
  }

  deleteGoodsById(String goodsId) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    cartString = sp.getString('cartInfo');
    List<Map> savedList = (json.decode(cartString.toString()) as List).cast();

    List<Map> tempList = [];
    tempList.addAll(savedList);
    savedList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        tempList.remove(item);
      }
    });
    savedList = tempList;
    cartString = json.encode(savedList).toString();
    sp.setString('cartInfo', cartString);
    await getCardInfo();
  }

  remove() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('cartInfo');
    notifyListeners();
  }

  changeGoodsSelectState(CartInfo cartInfo) async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    cartString = sp.getString('cartInfo');
    List<Map> savedList = (json.decode(cartString.toString()) as List).cast();

    int tempIndex = 0;

    int index = 0;
    savedList.forEach((item) {
      if (item['goodsId'] == cartInfo.goodsId) {
        tempIndex = index;
      }
      index++;
    });

    savedList[tempIndex] = cartInfo.toJson();
    cartString = json.encode(savedList).toString();
    sp.setString('cartInfo', cartString);
    await getCardInfo();
  }

  changeAllSelectedState(bool isSelected) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    cartString = sp.getString('cartInfo');

    List<Map> savedList = (json.decode(cartString.toString()) as List).cast();
    List<Map> tempList = [];

    savedList.forEach((item) {
      var newItem = item;
      newItem['isChecked'] = isSelected;
      tempList.add(newItem);
    });

    cartString = json.encode(tempList).toString();
    sp.setString('cartInfo', cartString);

    await getCardInfo();
  }

  reduceOrAddGoodsCount(CartInfo cartItem, String todo) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    cartString = sp.getString('cartInfo');

    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    int tempIndex = 0;
    int changeIndex = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == cartItem.goodsId) {
        changeIndex = tempIndex;
      }
      tempIndex++;
    });
    if (todo == 'add') {
      cartItem.count++;
    } else if (cartItem.count > 1) {
      cartItem.count--;
    }
    tempList[changeIndex] = cartItem.toJson();
    cartString = json.encode(tempList).toString();
    sp.setString('cartInfo', cartString); //
    await getCardInfo();
  }
}
