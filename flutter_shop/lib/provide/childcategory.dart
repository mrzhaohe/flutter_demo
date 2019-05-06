import 'package:flutter/material.dart';
import '../model/category.dart';

class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];
  int childIndex = 0;
  String categoryId = '4'; //大类 id
  String subCategoryId = ''; //子类 id
  int page = 1;
  String noMoreText = '';

  getChildCategory(List<BxMallSubDto> list, String catId) {
    categoryId = catId;
    childIndex = 0;
    page = 1;
    noMoreText = '';
    subCategoryId = '';
    BxMallSubDto all = BxMallSubDto();
    all.mallCategoryId = '00';
    all.comments = 'null';
    all.mallSubId = '';
    all.mallSubName = '全部';
    childCategoryList = [all];
    childCategoryList.addAll(list);

    notifyListeners();
  }

  changeChildIndex(int index, String subId) {
    childIndex = index;
    subCategoryId = subId;
    page = 1;
    noMoreText = '';
    notifyListeners();
  }

  addPage() {
    page++;
  }

  changeNoMoreText(String text) {
    noMoreText = text;
    notifyListeners();
  }
}
