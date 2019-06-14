import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_splash_screen/flutter_splash_screen.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_trip/dao/home_dao.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';
import 'package:flutter_trip/model/home_model.dart';
import 'package:flutter_trip/model/sales_box_model.dart';
import 'package:flutter_trip/pages/search_page.dart';
import 'package:flutter_trip/pages/speak_page.dart';
import 'package:flutter_trip/widget/grid_nav.dart';
import 'package:flutter_trip/widget/loading_container.dart';
import 'package:flutter_trip/widget/local_nav.dart';
import 'package:flutter_trip/widget/sales_box.dart';
import 'package:flutter_trip/widget/search_bar.dart';
import 'package:flutter_trip/widget/sub_nav.dart';
import 'package:flutter_trip/widget/webview.dart';

const APPBAR_SCROLL_OFFSET = 100; //滚动最大距离
const SEARCH_BAR_DEFAULT_TEXT = '网红打卡地 景点 酒店 没事';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  double appBarAlpha = 0;
  List<CommonModel> bannerList = [];
  List<CommonModel> localNavList = [];
  List<CommonModel> subNavList = [];
  GridNavModel gridNavModel;
  SalesBoxModel salesBox;
  bool _loading = true;

  _onScroll(offset) {
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0) {
      alpha = 0;
    }
    if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
  }

  @override
  void initState() {
    super.initState();
    _handleRefresh();
    //关闭启动屏
    FlutterSplashScreen.hide();
  }

  Future<Null> _handleRefresh() async {
    HomeDao.fetch().then((result) {
      setState(() {
        localNavList = result.localNavList;
        gridNavModel = result.gridNav;
        subNavList = result.subNavList;
        salesBox = result.salesBox;
        bannerList = result.bannerList;
      });
      _loading = false;
    }).catchError((result) {
      _loading = false;
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff2f2f2),
        body: LoadingContainer(
            isLoading: _loading,
            child: Stack(children: <Widget>[ //重叠放置，把AppBar放到ListView上层
              MediaQuery.removePadding( //移除ListView内置的padding
                  removeTop: true, //指定移除哪边
                  context: context,
                  child: RefreshIndicator(
                      onRefresh: _handleRefresh,
                      child: NotificationListener(
                          onNotification: (scrollNotification) {
                            if (scrollNotification is ScrollUpdateNotification &&
                                scrollNotification.depth == 0) {
                              //滚动且是列表滚动的时候,第0个元素滚动是出发监听
                              _onScroll(scrollNotification.metrics.pixels);
                            }
                          },
                          child: _listView))),
              _appBar,
            ],
            )
        ));
  }

  Widget get _listView {
    return ListView( //使用NotificationListener监听列表的滚动
      children: <Widget>[
        _bannerView,
        Padding(padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: LocalNavWidget(
              localNavList: localNavList),),
        Padding(padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
          child: GridNavWidget(
            gridNavModel: gridNavModel,),),
        Padding(padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
          child: SubNavWidget(subNavList: subNavList,),),
        Padding(padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
          child: SalesBoxWidget(
            salesBoxList: salesBox,),),
      ],
    );
  }

  Widget get _appBar {
    return Column(
      children: <Widget>[
        Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0x66000000), Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
            ),
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              height: 80.0,
              decoration: BoxDecoration(
                color: Color.fromARGB(
                    (appBarAlpha * 255).toInt(), 255, 255, 255),
              ),
              child: SearchBar(
                  searchBarType: appBarAlpha > 0.2
                      ? SearchBarType.homeLight
                      : SearchBarType
                      .home,
                  inputBoxClick: _jumpToSearch,
                  speckClick: _jumpToSpeak,
                  defaultText: SEARCH_BAR_DEFAULT_TEXT,
                  leftButtonClick: () {

                  }),
            )),
        Container(
          height: appBarAlpha > 0.2 ? 0.5 : 0,
          decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 0.5)]
          ),
        )
      ],
    );
  }

  Widget get _bannerView {
    return Container( //控制大小
      height: 160.0,
      child: Swiper(
        itemCount: bannerList.length,
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) =>
                      WebViewWidget(
                        title: bannerList[index].title,
                        url: bannerList[index].url,
                        statusBarColor: bannerList[index]
                            .statusBarColor,
                        hideAppBar: bannerList[index]
                            .hideAppBar,)));
            },
            child: Image.network(
              bannerList[index].icon
              , fit: BoxFit.fill,),
          );
        },
        pagination: SwiperPagination(),
      ),
    );
  }


  void _jumpToSearch() {
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => SearchPage(hint: SEARCH_BAR_DEFAULT_TEXT)));
  }

  void _jumpToSpeak() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SpeakPage()));
  }
}