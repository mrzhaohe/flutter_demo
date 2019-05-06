import 'package:flutter/material.dart';
import 'package:flutter_shop/pages/index_page.dart';
import 'package:provide/provide.dart';
import 'package:fluro/fluro.dart';

import 'provide/counter.dart';
import 'provide/childcategory.dart';
import 'provide/categoryGoodsList.dart';
import 'provide/detail_info.dart';

import './routers/routes.dart';
import './routers/application.dart';

void main() {
  var counter = Counter();
  var childCategory = ChildCategory();
  var categoryGoodsList = CategoryGoodsListProvide();
  var goodsDetail = GoodsDetailInfoProvide();
  var provides = Providers();

  provides..provide(Provider<Counter>.value(counter));
  provides..provide(Provider<ChildCategory>.value(childCategory));
  provides
    ..provide(Provider<CategoryGoodsListProvide>.value(categoryGoodsList));
  provides..provide(Provider<GoodsDetailInfoProvide>.value(goodsDetail));

  runApp(ProviderNode(providers: provides, child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;

    return Container(
      child: MaterialApp(
        title: '百姓生活+',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.blueAccent,
        ),
        home: IndexPage(),
      ),
    );
  }
}
