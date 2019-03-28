import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';

import '../config/service_method.dart';
import '../model/category.dart';

class CategoryPage extends StatefulWidget {
  final Widget child;

  CategoryPage({Key key, this.child}) : super(key: key);

  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品分类'),
      ),
      body: Container(
        child: Row(
          children: <Widget>[LeftCategoryNav()],
        ),
      ),
    );
  }
}

class LeftCategoryNav extends StatefulWidget {
  final Widget child;
  LeftCategoryNav({Key key, this.child}) : super(key: key);

  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
  List list = [];

  @override
  void initState() {
    _getCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: ScreenUtil().setWidth(180),
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            return _cellInkWell(index);
          },
        ));
  }

  _getCategory() async {
    await request('getCategory').then((value) {
      var data = json.decode(value.toString());

      Category category = Category.fromJson(data);
      setState(() {
        list = category.data;
      });
    });
  }

  Widget _cellInkWell(int index) {
    return InkWell(
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 10, top: 20),
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.black12))),
        child: Text(
          list[index].mallCategoryName,
          style: TextStyle(fontSize: ScreenUtil().setSp(26)),
        ),
      ),
    );
  }
}
