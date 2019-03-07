import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import '../config/service_method.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  final Widget child;
  HomePage({Key key, this.child}) : super(key: key);
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  String homePageContent = '正在获取数据';

  @override
  void initState() {
    super.initState();
    getHomePageContent().then((value) {
      setState(() {
        homePageContent = value.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print('设备像素比例---${ScreenUtil.pixelRatio}');
    print('设备的宽度---${ScreenUtil.screenWidth}');
    print('设备的高度---${ScreenUtil.screenHeight}');

    return Scaffold(
        body: FutureBuilder(
      future: getHomePageContent(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var data = json.decode(snapshot.data.toString());

          List<Map> dataList = (data['data']['slides'] as List).cast();
          List<Map> categoryList = (data['data']['category'] as List).cast();
          String bannerurl = data['data']['advertesPicture']['PICTURE_ADDRESS'];
          String leaderPhone = data['data']['shopInfo']['leaderPhone'];

          String leaderImage = data['data']['shopInfo']['leaderImage'];
          List<Map> recommendList = (data['data']['recommend'] as List).cast();
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                CustomSwiper(
                  swiperList: dataList,
                ),
                TopNavigator(categorylist: categoryList),
                AdBanner(banner_url: bannerurl),
                LeaderPhone(phone: leaderPhone, image: leaderImage),
                Recommend(
                  recommendList: recommendList,
                )
              ],
            ),
          );
        } else {
          return Center(
            child: Text('加载中...'),
          );
        }
      },
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
          return Image.network(
            '${swiperList[index]['image']}',
            fit: BoxFit.cover,
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
      child: Image.network(this.banner_url),
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

  Widget _item(index) {
    return Container(
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
          border: Border(right: BorderSide(width: 0.5, color: Colors.black12))),
    );
  }

  Widget _recommendList() {
    return Container(
      height: ScreenUtil().setHeight(330),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recommendList.length,
        itemBuilder: (context, index) {
          return _item(index);
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
