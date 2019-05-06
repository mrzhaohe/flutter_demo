// 商品详情

import 'package:flutter/material.dart';
import 'dart:convert';
import '../config/service_method.dart';
import '../model/goodsDetail.dart';

class GoodsDetailInfoProvide with ChangeNotifier {
  DetailsModel goodsModel;
  bool isLeft = true;
  bool isRight = false;
  getGoodsInfo(String goodsId) async {
    var formData = {'goodId': goodsId};

    request('getGoodDetailById', formData: formData).then((val) {
      var responseData = json.decode(val.toString());
      print(responseData);
      goodsModel = DetailsModel.fromJson(responseData);
      notifyListeners();
    });
  }

  changeLeftAndRight(String lr) {
    if (lr == 'Left') {
      isLeft = true;
      isRight = false;
    } else {
      isLeft = false;
      isRight = true;
    }
    notifyListeners();
  }
}
