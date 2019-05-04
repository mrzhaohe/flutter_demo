import 'package:flutter/material.dart';

import 'package:flutter_shop/pages/index_page.dart';

import 'package:provide/provide.dart';

import 'provide/counter.dart';

import 'provide/child_category.dart';

void main() {
  var counter = Counter();
  var childCategory = ChildCategory();
  var provides = Providers();

  provides..provide(Provider<Counter>.value(counter));
  provides..provide(Provider<ChildCategory>.value(childCategory));
  runApp(ProviderNode(providers: provides, child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
