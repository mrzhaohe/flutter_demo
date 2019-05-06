import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import '../config/service_method.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import '../routers/application.dart';

class HomePage extends StatefulWidget {
  final Widget child;
  HomePage({Key key, this.child}) : super(key: key);
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  int page = 1;
  List<Map> hotList = [];
  String homePageContent = '正在获取数据';
  GlobalKey<RefreshFooterState> _footerKey =
      new GlobalKey<RefreshFooterState>();
  @override
  void initState() {
    super.initState();
    _getHomePageContent();
    _getHotGoods();
  }

  ///获取首页顶部数据
  void _getHomePageContent() {
    request('homePageContent').then((value) {
      setState(() {
        homePageContent = value.toString();
      });
    });
  }

  ///获取底部火爆专区数据
  void _getHotGoods() {
    var formData = {'page': page};
    request('homePageBelowConten', formData: formData).then((value) {
      var data = json.decode(value.toString());
      List<Map> newGoodList = (data['data'] as List).cast();
      setState(() {
        hotList.addAll(newGoodList);
        page++;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('首页'),
        ),
        body: FutureBuilder(
          future: getHomePageContent(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = json.decode(snapshot.data.toString());

              List<Map> dataList = (data['data']['slides'] as List).cast();
              List<Map> categoryList =
                  (data['data']['category'] as List).cast();
              String bannerurl =
                  data['data']['advertesPicture']['PICTURE_ADDRESS'];
              String leaderPhone = data['data']['shopInfo']['leaderPhone'];
              String leaderImage = data['data']['shopInfo']['leaderImage'];
              List<Map> recommendList =
                  (data['data']['recommend'] as List).cast();
              String floor1title = data['data']['floor1Pic']['PICTURE_ADDRESS'];
              List<Map> floor1 =
                  (data['data']['floor1'] as List).cast(); //楼层1商品和图片

              return EasyRefresh(
                refreshFooter: ClassicsFooter(
                  key: _footerKey,
                  bgColor: Colors.white,
                  textColor: Colors.pink,
                  moreInfoColor: Colors.pink,
                  // showMore: true,
                  noMoreText: '',
                  // moreInfo: '上拉加载',
                  loadText: '上拉加载',
                  loadReadyText: 'loading...',
                  loadedText: 'success',
                  isFloat: false,
                  loadingText: 'loading...',
                  // loadHeight: 50.0,
                ),
                child: ListView(
                  children: <Widget>[
                    CustomSwiper(
                      swiperList: dataList,
                    ),
                    TopNavigator(categorylist: categoryList),
                    AdBanner(banner_url: bannerurl),
                    LeaderPhone(phone: leaderPhone, image: leaderImage),
                    Recommend(
                      recommendList: recommendList,
                    ),
                    FloorTitle(
                      picture_address: floor1title,
                    ),
                    FloorContent(
                      goodsList: floor1,
                    ),
                    _hotGoods(),
                  ],
                ),
                loadMore: () async {
                  print('loadmore');
                  var formData = {'page': page};
                  await request('homePageBelowConten', formData: formData)
                      .then((value) {
                    var data = json.decode(value.toString());
                    List<Map> newGoodList = (data['data'] as List).cast();
                    setState(() {
                      hotList.addAll(newGoodList);
                      page++;
                    });
                  });
                },
              );
            } else {
              return Center(
                child: Text('加载中...'),
              );
            }
          },
        ));
  }

  Widget _hotGoodsWrapList() {
    if (hotList.length != 0) {
      List<Widget> listWidgets = hotList.map((val) {
        return InkWell(
          onTap: () {},
          child: Container(
            width: ScreenUtil().setWidth(370),
            color: Colors.white,
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.only(bottom: 3.0),
            child: Column(
              children: <Widget>[
                Image.network(
                  val['image'],
                  width: ScreenUtil().setWidth(370),
                ),
                Text(val['name'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.pink, fontSize: ScreenUtil().setSp(26))),
                Row(
                  children: <Widget>[
                    Text(
                      '${val['mallPrice']}',
                    ),
                    Text(
                      '¥${val['price']}',
                      style: TextStyle(
                          color: Colors.black26,
                          decoration: TextDecoration.lineThrough),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList();

      return Wrap(
        spacing: 2,
        children: listWidgets,
      );
    } else {
      return Text('');
    }
  }

  Widget _hotTitle() {
    return Container(
      // alignment: Alignment.center,
      margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.all(5.0),
      child: Text('火爆专区', style: TextStyle(color: Colors.pink)),
    );
  }

  Widget _hotGoods() {
    return Container(
        child: Column(
      children: <Widget>[
        _hotTitle(),
        _hotGoodsWrapList(),
      ],
    ));
  }

  @override
  bool get wantKeepAlive => true;
}

///轮播
class CustomSwiper extends StatelessWidget {
  final List swiperList;
  // Swiper({Key key, this.swiperList}) : super(key: key);
  CustomSwiper({this.swiperList});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(300),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemCount: swiperList.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Application.router.navigateTo(
                  context, "/detail?id=${swiperList[index]['goodsId']}");
            },
            child: Image.network(
              '${swiperList[index]['image']}',
              fit: BoxFit.cover,
            ),
          );
        },
        pagination: SwiperPagination(
            margin: EdgeInsets.all(0.0),
            alignment: Alignment.bottomCenter,
            builder: DotSwiperPaginationBuilder(activeColor: Colors.grey)),
        autoplay: true,
        control: SwiperControl(color: Colors.blue[300]),
      ),
    );
  }
}

///中间分类
class TopNavigator extends StatelessWidget {
  final List categorylist;
  TopNavigator({this.categorylist});
  @override
  Widget build(BuildContext context) {
    if (this.categorylist.length > 10) {
      this.categorylist.removeRange(10, this.categorylist.length);
    }
    return Container(
        height: ScreenUtil().setHeight(320),
        padding: EdgeInsets.all(5.0),
        child: GridView.count(
          physics: new NeverScrollableScrollPhysics(), //禁止滑动
          padding: EdgeInsets.all(10.0),
          crossAxisCount: 5,
          children: categorylist.map((item) {
            return _gridViewItem(context, item);
          }).toList(),
        ));
  }

  Widget _gridViewItem(BuildContext context, item) {
    return InkWell(
      onTap: () {
        print(item['mallCategoryName']);
      },
      child: Column(
        children: <Widget>[
          Image.network(
            item['image'],
            width: ScreenUtil().setWidth(95),
          ),
          Text(item['mallCategoryName']),
        ],
      ),
    );
  }
}

///广告
class AdBanner extends StatelessWidget {
  final String banner_url;

  AdBanner({Key key, this.banner_url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(banner_url),
    );
  }
}

///店长
class LeaderPhone extends StatelessWidget {
  final String phone;
  final String image;

  LeaderPhone({Key key, this.phone, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: _dial,
        child: Image.network(image),
      ),
    );
  }

  void _dial() async {
    String url = 'tel:' + phone;
    // url = 'https://www.jspang.com';
    // url = 'sms:' + '13121892189';
    print(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

///推荐
class Recommend extends StatelessWidget {
  final List recommendList;

  Recommend({Key key, this.recommendList}) : super(key: key);

  Widget _titlewidget() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10.0, 5.0, 0, 5.0),
      child: Text('商品推荐', style: TextStyle(color: Colors.pink)),
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(bottom: BorderSide(width: 0.5, color: Colors.black12))),
    );
  }

  Widget _item(index, context) {
    return InkWell(
      onTap: () {
        Application.router.navigateTo(
            context, "/detail?id=${recommendList[index]['goodsId']}");
      },
      child: Container(
        padding: EdgeInsets.all(8.0),
        height: ScreenUtil().setHeight(330),
        width: ScreenUtil().setWidth(250),
        child: Column(
          children: <Widget>[
            Image.network(recommendList[index]['image']),
            Text(
              '¥${recommendList[index]['price']}',
              style: TextStyle(
                  decoration: TextDecoration.lineThrough, color: Colors.grey),
            ),
            Text('¥${recommendList[index]['mallPrice']}'),
          ],
        ),
        decoration: BoxDecoration(
            border:
                Border(right: BorderSide(width: 0.5, color: Colors.black12))),
      ),
    );
  }

  Widget _recommendList() {
    return Container(
      height: ScreenUtil().setHeight(330),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recommendList.length,
        itemBuilder: (context, index) {
          return _item(index, context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: ScreenUtil().setHeight(400),
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          _titlewidget(),
          _recommendList(),
        ],
      ),
    );
  }
}

class FloorTitle extends StatelessWidget {
  final String picture_address;

  FloorTitle({Key key, this.picture_address});

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Image.network(this.picture_address),
    );
  }
}

class FloorContent extends StatelessWidget {
  final List goodsList;

  FloorContent({Key key, this.goodsList});

  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[_firstRow(context), _otherRow(context)],
      ),
    );
  }

  Widget _firstRow(context) {
    return Row(
      children: <Widget>[
        _item(goodsList[0], context),
        Column(
          children: <Widget>[
            _item(goodsList[1], context),
            _item(goodsList[2], context),
          ],
        )
      ],
    );
  }

  Widget _otherRow(context) {
    return Row(
      children: <Widget>[
        _item(goodsList[3], context),
        _item(goodsList[4], context),
      ],
    );
  }

  Widget _item(Map good, BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(375),
      child: InkWell(
        onTap: () {
          Application.router
              .navigateTo(context, "/detail?id=${good['goodsId']}");
        },
        child: Image.network(good['image']),
      ),
    );
  }
}
