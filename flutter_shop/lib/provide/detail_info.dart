import 'package:flutter/material.dart';
import 'dart:convert';
import '../config/service_method.dart';
import '../model/goodsDetail.dart';

class GoodsDetailInfoProvide with ChangeNotifier {
  GoodsDetailModel goodsModel;
  getGoodsInfo(String goodsId) {
    var formData = {'goodId': goodsId};

    request('getGoodDetailById', formData: formData).then((val) {
      var responseData = json.decode(val.toString());
      print(responseData);
      goodsModel = GoodsDetailModel.fromJson(responseData);
      notifyListeners();
    });
  }
}
