import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import '../config/service_method.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

          return Column(
            children: <Widget>[
              CustomSwiper(
                swiperList: dataList,
              ),
              TopNavigator(categorylist: categoryList)
            ],
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
