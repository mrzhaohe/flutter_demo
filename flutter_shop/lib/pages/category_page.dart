import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';

import '../config/service_method.dart';
import '../model/category.dart';
import '../model/categoryGoodsList.dart';

import '../provide/childcategory.dart';
import '../provide/categoryGoodsList.dart';

import 'package:provide/provide.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../routers/application.dart';

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
    _getGoodsList();
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

// 获取左侧分类
  void _getCategory() async {
    await request('getCategory').then((value) {
      var data = json.decode(value.toString());

      Category category = Category.fromJson(data);
      setState(() {
        list = category.data;
      });

      Provide.value<ChildCategory>(context)
          .getChildCategory(list[0].bxMallSubDto, list[0].mallCategoryId);
    });
  }

//获取商品
  void _getGoodsList({String categoryId}) async {
    var param = {
      'categoryId': categoryId == null ? '4' : categoryId,
      'categorySubId': '',
      'page': '1'
    };
    await request('getMallGoods', formData: param).then((val) {
      var data = json.decode(val.toString());
      CategoryGoodsListModel goodsListModel =
          CategoryGoodsListModel.fromJson(data);
      Provide.value<CategoryGoodsListProvide>(context)
          .getGoodsList(goodsListModel.data);
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
        var categoryId = list[index].mallCategoryId;
        _getGoodsList(categoryId: categoryId);
        Provide.value<ChildCategory>(context)
            .getChildCategory(childList, categoryId);
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
              return _rightNavItem(
                  childCategory.childCategoryList[index], index);
            },
          ),
        );
      },
    );
  }

  Widget _rightNavItem(BxMallSubDto item, int index) {
    bool isSelected = false;

    isSelected = (index == Provide.value<ChildCategory>(context).childIndex)
        ? true
        : false;

    return InkWell(
      onTap: () {
        Provide.value<ChildCategory>(context)
            .changeChildIndex(index, item.mallSubId);
        _getGoodsList(item.mallSubId);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
        child: Text(item.mallSubName,
            style: TextStyle(
                fontSize: ScreenUtil().setSp(28),
                color: isSelected ? Colors.pink : Colors.black)),
      ),
    );
  }

  void _getGoodsList(String categorySubId) async {
    var param = {
      'categoryId': Provide.value<ChildCategory>(context).categoryId,
      'categorySubId': categorySubId,
      'page': '1'
    };
    await request('getMallGoods', formData: param).then((val) {
      var data = json.decode(val.toString());
      CategoryGoodsListModel goodsListModel =
          CategoryGoodsListModel.fromJson(data);

      if (goodsListModel.data == null) {
        Provide.value<CategoryGoodsListProvide>(context).getGoodsList([]);
      } else {
        Provide.value<CategoryGoodsListProvide>(context)
            .getGoodsList(goodsListModel.data);
      }
    });
  }
}

class CategoryGoodsList extends StatefulWidget {
  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {
  GlobalKey<RefreshFooterState> _footerKey =
      new GlobalKey<RefreshFooterState>();
  var scrollController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodsListProvide>(
      builder: (context, child, data) {
        try {
          if (Provide.value<ChildCategory>(context).page == 1) {
            scrollController.jumpTo(0.0);
          }
        } catch (e) {}
        if (data.goodsList.length > 0) {
          return Expanded(
              child: Container(
                  width: ScreenUtil().setWidth(570),
                  child: EasyRefresh(
                    refreshFooter: ClassicsFooter(
                      key: _footerKey,
                      bgColor: Colors.white,
                      textColor: Colors.pink,
                      moreInfoColor: Colors.pink,
                      showMore: true,
                      noMoreText:
                          Provide.value<ChildCategory>(context).noMoreText,
                      moreInfo: '加载中',
                      loadReadyText: '上拉加载',
                    ),
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: data.goodsList.length,
                      itemBuilder: (context, index) {
                        return _goodsItemWidget(data.goodsList[index]);
                      },
                    ),
                    loadMore: () async {
                      // print('没有更多.....');
                      _getMoreList();
                    },
                  )));
        } else {
          return Text('暂无数据');
        }
      },
    );
  }

  void _getMoreList() {
    Provide.value<ChildCategory>(context).addPage();
    var param = {
      'categoryId': Provide.value<ChildCategory>(context).categoryId,
      'categorySubId': Provide.value<ChildCategory>(context).subCategoryId,
      'page': Provide.value<ChildCategory>(context).page
    };

    request('getMallGoods', formData: param).then((val) {
      var data = json.decode(val.toString());
      CategoryGoodsListModel goodList = CategoryGoodsListModel.fromJson(data);

      if (goodList.data == null) {
        Provide.value<ChildCategory>(context).changeNoMoreText('没有更多了');
        Fluttertoast.showToast(
            msg: "已经到底了",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Colors.pink,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Provide.value<CategoryGoodsListProvide>(context)
            .addGoodsList(goodList.data);
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  Widget _goodsItemWidget(CategoryListData listData) {
    return InkWell(
        onTap: () {
          Application.router
              .navigateTo(context, 'detail?id=${listData.goodsId}');
        },
        child: Container(
          padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  bottom: BorderSide(width: 1.0, color: Colors.black12))),
          child: Row(
            children: <Widget>[
              _goodsImage(listData),
              Column(
                children: <Widget>[_goodsName(listData), _goodsPrice(listData)],
              )
            ],
          ),
        ));
  }

  Widget _goodsImage(CategoryListData goodsItem) {
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(goodsItem.image),
    );
  }

  Widget _goodsName(CategoryListData goodsItem) {
    return Container(
      padding: EdgeInsets.all(5.0),
      width: ScreenUtil().setWidth(370),
      child: Text(
        goodsItem.goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil().setSp(28)),
      ),
    );
  }

  Widget _goodsPrice(CategoryListData goodsItem) {
    return Container(
        margin: EdgeInsets.only(top: 20),
        width: ScreenUtil().setWidth(370),
        child: Row(
          children: <Widget>[
            Text(
              '价格:￥${goodsItem.presentPrice}',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(30), color: Colors.pink),
            ),
            Text(
              '￥${goodsItem.oriPrice}',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(26),
                color: Colors.black26,
                decoration: TextDecoration.lineThrough,
              ),
            )
          ],
        ));
  }
}
