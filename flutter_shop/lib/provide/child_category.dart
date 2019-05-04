import 'package:flutter/material.dart';
import '../model/category.dart';

class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];

  getChildCategory(List<BxMallSubDto> list) {
    BxMallSubDto all = BxMallSubDto();
    all.mallCategoryId = '00';
    all.comments = 'null';
    all.mallSubName = '全部';
    all.mallSubId = '00';

    childCategoryList = [all];
    childCategoryList.addAll(list);

    notifyListeners();
  }
}
