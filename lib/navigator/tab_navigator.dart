import 'package:flutter/material.dart';
import 'package:flutter_trip/pages/home_page.dart';
import 'package:flutter_trip/pages/my_page.dart';
import 'package:flutter_trip/pages/search_page.dart';
import 'package:flutter_trip/pages/travel_page.dart';

class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState() => _TabNavigatorState();

}
/**
 * 内部类前面加"_"可以不被外部类访问
 */
class _TabNavigatorState extends State<TabNavigator> {

  final _defaultColor = Colors.grey;
  final _activeColor = Colors.blue;

  int _currentIndex = 0;

  final PageController _controller = PageController(
    //初始状态下，刚打开时所在的页面
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: PageView(
        controller: _controller,
        //要现实的页面
        children: <Widget>[
          HomePage(),
          SearchPage(hideLeft: true,),
          TravelPage(),
          MyPage(),
        ],
        //禁止滑动
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          //点击tab切换
          onTap: (index) {
            _controller.jumpToPage(index);
            setState(() {
              _currentIndex = index;
            });
          },
          //设置底部导航label（文字）一直显示
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home,
                  color: _defaultColor,),
                activeIcon: Icon(Icons.home,
                  color: _activeColor,),
                title: Text('首页', style: TextStyle(
                    color: _currentIndex != 0 ? _defaultColor : _activeColor),)
            ), BottomNavigationBarItem(
                icon: Icon(Icons.search,
                  color: _defaultColor,),
                activeIcon: Icon(Icons.search,
                  color: _activeColor,),
                title: Text('搜索', style: TextStyle(
                    color: _currentIndex != 1 ? _defaultColor : _activeColor),)
            ), BottomNavigationBarItem(
                icon: Icon(Icons.camera,
                  color: _defaultColor,),
                activeIcon: Icon(Icons.camera,
                  color: _activeColor,),
                title: Text('旅拍', style: TextStyle(
                    color: _currentIndex != 2 ? _defaultColor : _activeColor),)
            ), BottomNavigationBarItem(
                icon: Icon(Icons.account_circle,
                  color: _defaultColor,),
                activeIcon: Icon(Icons.account_circle,
                  color: _activeColor,),
                title: Text('我的', style: TextStyle(
                    color: _currentIndex != 3 ? _defaultColor : _activeColor),)
            )
          ]),
    );
  }

}