import 'package:flutter/material.dart';
import '../model/category.dart';

class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];
  int childIndex = 0;
  String categoryId = '4'; //大类 id
  String subCategoryId = ''; //子类 id

  getChildCategory(List<BxMallSubDto> list, String catId) {
    categoryId = catId;
    childIndex = 0;

    BxMallSubDto all = BxMallSubDto();
    all.mallCategoryId = '00';
    all.comments = 'null';
    all.mallSubName = '全部';
    all.mallSubId = '00';

    childCategoryList = [all];
    childCategoryList.addAll(list);

    notifyListeners();
  }

  changeChildIndex(int index, String subId) {
    childIndex = index;
    subCategoryId = subId;
    notifyListeners();
  }
}
