import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_shop/pages/home_page.dart';
import 'package:flutter_shop/pages/category_page.dart';
import 'package:flutter_shop/pages/cart_page.dart';
import 'package:flutter_shop/pages/member_page.dart';

import '../provide/currentIndex.dart';
import 'package:provide/provide.dart';

// class IndexPage extends StatefulWidget {
//   _IndexPageState createState() => _IndexPageState();
// }

// class _IndexPageState extends State<IndexPage>
//     with SingleTickerProviderStateMixin {
//   // @override
//   // bool get wantKeepAlive => true;

//   List<BottomNavigationBarItem> items;
//   TabController _controller;
//   final List<Widget> pages = [
//     HomePage(),
//     CategoryPage(),
//     ShoppingPage(),
//     MemberPage()
//   ];
//   int currentIndex = 0;
//   var currentPage;

//   @override
//   void initState() {
//     currentPage = pages[currentIndex];
//     super.initState();

//     items = [
//       BottomNavigationBarItem(
//           icon: Icon(CupertinoIcons.home), title: Text('首页')),
//       BottomNavigationBarItem(
//           icon: Icon(CupertinoIcons.search), title: Text('分类')),
//       BottomNavigationBarItem(
//           icon: Icon(CupertinoIcons.shopping_cart), title: Text('购物车')),
//       BottomNavigationBarItem(
//           icon: Icon(CupertinoIcons.profile_circled), title: Text('会员中心')),
//     ];
//     _controller = TabController(length: items.length, vsync: this);
//   }

//   @override
//   Widget build(BuildContext context) {
//     ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);

//     return Provide<CurrentIndexProvide>(
//       builder: (context,child,data){
//         int currentIndex = Provide.value<CurrentIndexProvide>(context).currentIndex;

//         return Scaffold(
//         backgroundColor: Colors.black87,
//         // appBar: AppBar(
//         //   title: Text('百姓生活+'),
//         // ),
//         bottomNavigationBar: BottomNavigationBar(
//           items: items,
//           type: BottomNavigationBarType.fixed,
//           onTap: (index) {
//             setState(() {
//               currentIndex = index;
//               currentPage = pages[index];
//             });
//             _controller.animateTo(currentIndex);
//           },
//           currentIndex: currentIndex,
//         ),
//         // body: currentPage,

//         body: TabBarView(
//             controller: _controller,
//             physics: NeverScrollableScrollPhysics(),
//             children: pages),

//         // body: IndexedStack(index: currentIndex, children: pages),
//       );
//       },
//     );
//   }
// }

class IndexPage extends StatelessWidget {
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), title: Text('首页')),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.search), title: Text('分类')),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.shopping_cart), title: Text('购物车')),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.profile_circled), title: Text('会员中心')),
  ];

  final List<Widget> tabBars = [
    HomePage(),
    CategoryPage(),
    ShoppingPage(),
    MemberPage()
  ];
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);

    return Provide<CurrentIndexProvide>(
      builder: (context, child, data) {
        int currentIndex =
            Provide.value<CurrentIndexProvide>(context).currentIndex;

        return Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: currentIndex,
              items: bottomTabs,
              onTap: (index) {
                Provide.value<CurrentIndexProvide>(context).changeIndex(index);
              },
            ),
            body: IndexedStack(index: currentIndex, children: tabBars));
      },
    );
  }
}
