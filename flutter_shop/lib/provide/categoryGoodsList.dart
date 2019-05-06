// 商品列表

import 'package:flutter/material.dart';

import '../model/categoryGoodsList.dart';

class CategoryGoodsListProvide with ChangeNotifier {
  List<CategoryListData> goodsList = [];
  getGoodsList(List<CategoryListData> list) {
    goodsList = list;
    notifyListeners();
  }

  //上拉加载列表
  addGoodsList(List<CategoryListData> list) {
    goodsList.addAll(list);
    notifyListeners();
  }
}
