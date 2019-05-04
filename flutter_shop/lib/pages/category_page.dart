import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';

import '../config/service_method.dart';
import '../model/category.dart';
import '../model/categoryGoodsList.dart';
import '../provide/child_category.dart';
import 'package:provide/provide.dart';

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
          children: <Widget>[
            LeftCategoryNav(),
            Container(
              child: Column(
                children: <Widget>[RightTopNav(), CategoryGoodsList()],
              ),
            )
          ],
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
  var listIndex = 0;
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

      Provide.value<ChildCategory>(context)
          .getChildCategory(list[0].bxMallSubDto);
    });
  }

  Widget _cellInkWell(int index) {
    bool isSelected = false;
    isSelected = (index == listIndex);
    return InkWell(
      onTap: () {
        setState(() {
          listIndex = index;
        });
        var childList = list[index].bxMallSubDto;
        Provide.value<ChildCategory>(context).getChildCategory(childList);
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 10, top: 20),
        decoration: BoxDecoration(
            color:
                isSelected ? Color.fromRGBO(245, 245, 245, 1.0) : Colors.white,
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

class RightTopNav extends StatefulWidget {
  _RightTopNavState createState() => _RightTopNavState();
}

class _RightTopNavState extends State<RightTopNav> {
  @override
  Widget build(BuildContext context) {
    return Provide<ChildCategory>(
      builder: (context, child, childCategory) {
        return Container(
          height: ScreenUtil().setHeight(80),
          width: ScreenUtil().setWidth(570),
          decoration: BoxDecoration(
              color: Colors.white,
              border:
                  Border(bottom: BorderSide(width: 0.3, color: Colors.grey))),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: childCategory.childCategoryList.length,
            itemBuilder: (context, index) {
              return _rightNavItem(childCategory.childCategoryList[index]);
            },
          ),
        );
      },
    );
  }

  Widget _rightNavItem(BxMallSubDto item) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
        child: Text(item.mallSubName,
            style: TextStyle(fontSize: ScreenUtil().setSp(28))),
      ),
    );
  }
}

class CategoryGoodsList extends StatefulWidget {
  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {
  List goodsList = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(570),
      height: ScreenUtil().setHeight(1000),
      child: ListView.builder(
          itemCount: goodsList.length,
          itemBuilder: (context, index) {
            return _goodsItemWidget(index);
          }),
    );
  }

  @override
  void initState() {
    _getGoodsList();
    super.initState();
  }

  void _getGoodsList() async {
    var param = {'categoryId': '4', 'CategorySubId': '', 'page': '1'};
    await request('getMallGoods', formData: param).then((val) {
      var data = json.decode(val.toString());
      CategoryGoodsListModel goodsListModel =
          CategoryGoodsListModel.fromJson(data);
      setState(() {
        goodsList = goodsListModel.data;
      });
    });
  }

  Widget _goodsImage(index) {
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(goodsList[index].image),
    );
  }

  Widget _goodsName(index) {
    return Container(
      padding: EdgeInsets.all(5.0),
      width: ScreenUtil().setWidth(370),
      child: Text(
        goodsList[index].goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil().setSp(28)),
      ),
    );
  }

  Widget _goodsPrice(index) {
    return Container(
        margin: EdgeInsets.only(top: 20),
        width: ScreenUtil().setWidth(370),
        child: Row(
          children: <Widget>[
            Text(
              '价格： ￥${goodsList[index].presentPrice}',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(30), color: Colors.pink),
            ),
            Text(
              '￥${goodsList[index].oriPrice}',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(26),
                color: Colors.black26,
                decoration: TextDecoration.lineThrough,
              ),
            )
          ],
        ));
  }

  Widget _goodsItemWidget(index) {
    return InkWell(
        child: Container(
      child: Row(
        children: <Widget>[
          _goodsImage(index),
          Column(
            children: <Widget>[_goodsName(index), _goodsPrice(index)],
          )
        ],
      ),
    ));
  }
}
