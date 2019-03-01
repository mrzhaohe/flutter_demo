import 'package:flutter/material.dart';
import 'package:demo_layout/leftDrawer/DanduPage.dart';
import 'package:demo_layout/leftDrawer/DuzhePage.dart';

class TalkPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(child: TalkfulPage());
  }
}

class TalkfulPage extends StatefulWidget {
  _TalkfulPageState createState() => _TalkfulPageState();
}

class _TalkfulPageState extends State<TalkfulPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, initialIndex: 0, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('谈论'),
          bottom: new TabBar(
            controller: _tabController,
            isScrollable: false,
            unselectedLabelColor: Colors.white70,
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            indicatorWeight: 2.0,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorPadding: EdgeInsets.only(bottom: 1),
            tabs: <Widget>[
              new Tab(
                text: '单独问',
              ),
              new Tab(
                text: '读者论',
              )
            ],
          )),
      body: new TabBarView(
        controller: _tabController,
        children: <Widget>[
          new DanduPage(),
          new DuzhePage(),
        ],
      ),
    );
  }
}
