import 'package:flutter/material.dart';
import 'package:flutter_trip/dao/travel_tab_dao.dart';
import 'package:flutter_trip/model/travel_model.dart';
import 'package:flutter_trip/model/travel_tab_model.dart';
import 'package:flutter_trip/pages/travel_tab_page.dart';

class TravelPage extends StatefulWidget {
  @override
  _TravelPageState createState() => _TravelPageState();

}

class _TravelPageState extends State<TravelPage>
    with SingleTickerProviderStateMixin {

  TabController _controller;
  List<TravelTab> tabs = [];
  TravelTabModel travelTabModel;

  @override
  void initState() {
    _controller = TabController(length: 0, vsync: this);
    TravelTabDao.fetch().then((TravelTabModel model) {
      //获取到数据后从新初始化controller否则不会刷新tabs，（本地写死的tab不需要）
      _controller = TabController(length: model.tabs.length, vsync: this);
      setState(() {
        tabs = model.tabs;
        travelTabModel = model;
      });
    }).catchError((e) {
      print(e);
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
              color: Colors.white,
              padding: EdgeInsets.only(top: 30),
              child: TabBar(
                  controller: _controller,
                  isScrollable: true,
                  labelColor: Colors.black,
                  labelPadding: EdgeInsets.fromLTRB(20, 0, 10, 5),
                  indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(
                          color: Color(0xff2fcfbb),
                          width: 3
                      ),
                      insets: EdgeInsets.only(bottom: 10)
                  ),
                  tabs: tabs.map<Tab>((TravelTab tab) {
                    return Tab(text: tab.labelName);
                  }).toList()
              )),
          //也可以使用Flexible,Flexible是填充剩余空间，Expanded是按比例分割
          Expanded(child: TabBarView(
              controller: _controller,
              children: tabs.map((TravelTab tab) {
                return TravelTabPage(travelUrl: travelTabModel.url,groupChannelCode: tab.groupChannelCode,);
              }).toList()), flex: 1,)
        ],
      ),
    );
  }

}