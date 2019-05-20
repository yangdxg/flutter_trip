import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

const APPBAR_SCROLL_OFFSET = 100; //滚动最大距离

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {

  List _imageUrl = [
    'https://dimg04.c-ctrip.com/images/700f14000000vwyovE2FE_1920_340_17.jpg',
    'https://dimg04.c-ctrip.com/images/700l14000000w7063D530_1920_340_17.jpg',
    'https://dimg04.c-ctrip.com/images/700q14000000w3rrz27EA_1920_340_17.jpg',
  ];

  double appBarAlpha = 0;

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
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[ //重叠放置，把AppBar放到ListView上层
          MediaQuery.removePadding( //移除ListView内置的padding
              removeTop: true, //指定移除哪边
              context: context,
              child: NotificationListener(
                onNotification: (scrollNotification) {
                  if (scrollNotification is ScrollUpdateNotification &&
                      scrollNotification.depth == 0) {
                    //滚动且是列表滚动的时候,第0个元素滚动是出发监听
                    _onScroll(scrollNotification.metrics.pixels);
                  }
                },
                child: ListView( //使用NotificationListener监听列表的滚动
                  children: <Widget>[
                    Container( //控制大小
                      height: 160.0,
                      child: Swiper(
                        itemCount: _imageUrl.length,
                        autoplay: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Image.network(
                            _imageUrl[index]
                            , fit: BoxFit.fill,);
                        },
                        pagination: SwiperPagination(),
                      ),
                    ), Container(
                      height: 800.0,
                      child: ListTile(title: Text('title'),),
                    )
                  ],
                ),)),
          Opacity( //设置透明度使用Opcity包裹需要设置透明度的控件
            opacity: appBarAlpha,
            child: Container(
              height: 80,
              decoration: BoxDecoration(color: Colors.white),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text('首页'),),
              ),
            ),
          )
        ],
        ));
  }
}