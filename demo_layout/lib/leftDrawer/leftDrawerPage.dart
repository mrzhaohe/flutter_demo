import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:demo_layout/leftDrawer/TalkPage.dart';

class LeftDrawer extends StatefulWidget {
  final double widthPercent;

  const LeftDrawer({Key key, this.widthPercent = 0.7}) : super(key: key);
  @override
  _LeftDrawerState createState() => _LeftDrawerState();
}

class _LeftDrawerState extends State<LeftDrawer> {
  @override
  Widget build(BuildContext context) {
    final double _width =
        MediaQuery.of(context).size.width * widget.widthPercent;
    return ConstrainedBox(
      constraints: BoxConstraints.expand(width: _width),
      child: Material(
        color: Colors.black,
        child: Column(
          children: <Widget>[
            new Container(
              padding: EdgeInsets.only(top: 30, left: 15, right: 15),
              child: _navigationBarWidget(context),
            ),
            new Center(
                child: Text(
              '单读',
              style: TextStyle(color: Colors.white, fontSize: 24),
            )),
            LineTips(
              centerTitle: Text(
                'We Read The World',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
            new Container(
              padding: EdgeInsets.only(left: 15, top: 30, right: 15),
              width: 200,
              height: 450,
              child: _categoryListView(context),
            ),
            new Container(
              padding: EdgeInsets.only(top: 30),
              child: _bottomText(),
            )
          ],
        ),
      ),
    );
  }

  Widget _bottomText() {
    return new Center(
      child: Text(
        'Powered by mrzhaohe',
        style: TextStyle(color: Colors.white54, fontSize: 13),
      ),
    );
  }

  Widget _animationText(String str) {
    return SizedBox(
        child: ScaleAnimatedTextKit(
      text: [str],
      duration: Duration(milliseconds: 4000),
      isRepeatingAnimation: false,
      textStyle: TextStyle(fontSize: 35, color: Colors.white),
    ));
  }

  Widget _categoryListView(BuildContext contetx) {
    return Column(
      children: <Widget>[
        new Expanded(
          child: new FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: _animationText('首页'),
          ),
        ),
        new Expanded(
          child: new FlatButton(
            onPressed: () {},
            child: _animationText('文字'),
          ),
        ),
        new Expanded(
          child: new FlatButton(
            onPressed: () {},
            child: _animationText('声音'),
          ),
        ),
        new Expanded(
          child: new FlatButton(
            onPressed: () {},
            child: _animationText('影像'),
          ),
        ),
        new Expanded(
          child: new FlatButton(
            onPressed: () {
              Navigator.of(context).push(new MaterialPageRoute(builder: (ctx) {
                return new TalkPage();
              }));
            },
            child: _animationText('谈论'),
          ),
        ),
        new Expanded(
          child: new FlatButton(
            onPressed: () {},
            child: _animationText('单向历'),
          ),
        ),
      ],
    );
  }

  Widget _navigationBarWidget(BuildContext context) {
    return Row(
      children: <Widget>[
        new Container(
          width: 45,
          height: 45,
          child: new IconButton(
            icon: Image.asset('assets/tianyanbi@2x.png'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        new Expanded(
          child: new Container(
            color: Colors.black,
          ),
        ),
        new Container(
          width: 45,
          height: 45,
          child: new IconButton(
            icon: Icon(Icons.search),
            color: Colors.white,
            onPressed: () {},
          ),
        )
      ],
    );
  }
}

class LineTips extends StatelessWidget {
  LineTips({Key key, @required this.centerTitle}) : super(key: key);
  final Widget centerTitle;
  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: EdgeInsets.only(left: 0),
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Container(
              margin: EdgeInsets.only(right: 10),
              height: 0.3,
              color: Colors.white70,
            ),
          ),
          centerTitle,
          new Expanded(
            child: new Container(
              margin: EdgeInsets.only(left: 10),
              height: 0.3,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
