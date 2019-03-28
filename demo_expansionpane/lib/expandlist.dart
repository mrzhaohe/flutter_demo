import 'package:flutter/material.dart';
import './expandbean.dart';

class ExpandListDemo extends StatefulWidget {
  _ExpandListDemoState createState() => _ExpandListDemoState();
}

class _ExpandListDemoState extends State<ExpandListDemo> {
  int currentIndex = 0;
  List<int> mList;
  List<ExpandStateBean> expandStateList;
  _ExpandListDemoState() {
    mList = new List();
    expandStateList = new List();
    for (int i = 0; i < 20; i++) {
      mList.add(i);
      expandStateList.add(ExpandStateBean(i, false));
    }
  }

  void _setCurrentPanelState(int index, bool isOpen) {
    setState(() {
      expandStateList.forEach((item) {
        if (item.index == index) {
          item.isOpen = !isOpen;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: ExpansionPanelList(
          expansionCallback: (index, bol) {
            _setCurrentPanelState(index, bol);
          },
          children: mList.map((index) {
            return ExpansionPanel(
              headerBuilder: (context, isExpanded) {
                return ListTile(
                  title: Text('this is no. $index'),
                );
              },
              body: ListTile(
                title: Text('expand no.$index'),
              ),
              isExpanded: expandStateList[index].isOpen,
            );
          }).toList(),
        ),
      ),
    );
  }
}
