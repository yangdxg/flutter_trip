import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

//添加白名单,返回时判断如果是一下域名的网址就pop到上级页面（防止在webview中返回，回不到原生界面）
const CATCH_URLS = ['m.ctrip.com/', 'm.ctrip.com/html5', 'm.ctrip.com/html5'];

class WebViewWidget extends StatefulWidget {

  final String url;
  final String statusBarColor;
  final String title;
  final bool hideAppBar;
  final bool backForbid;


  WebViewWidget({this.url, this.statusBarColor, this.title, this.hideAppBar,
    this.backForbid = false});

  @override
  _WebViewWidgetState createState() => _WebViewWidgetState();

}

class _WebViewWidgetState extends State<WebViewWidget> {
  final FlutterWebviewPlugin webviewReference = FlutterWebviewPlugin();
  StreamSubscription<String> _onUrlChanged;
  StreamSubscription<WebViewStateChanged> _onStateChanged;
  StreamSubscription<WebViewHttpError> _onHttpError;

  //不重复返回
  bool exiting = false;

  @override
  void initState() {
    super.initState();
    //放置页面重新打开
    webviewReference.close();
    //监听页面url变化
    _onUrlChanged = webviewReference.onUrlChanged.listen((String url) {

    });
    //页面状态发生变化时
    _onStateChanged =
        webviewReference.onStateChanged.listen((WebViewStateChanged state) {
          switch (state.type) {
            case WebViewState.shouldStart:
            //开始加载时
              if (_isToMain(state.url) && !exiting) {
                if (widget.backForbid) { //禁止返回
                  webviewReference.launch(widget.url);
                } else {
                  //返回到上一页
                  Navigator.pop(context);
                  exiting = true;
                }
              }
              break;
            case WebViewState.startLoad:
              break;
            case WebViewState.finishLoad:
              break;
            case WebViewState.abortLoad:
              break;
            default:
              break;
          }
        });
    //加载错误监听
    _onHttpError =
        webviewReference.onHttpError.listen((WebViewHttpError error) {

        });
  }

  _isToMain(String url) {
    bool contain = false;
    for (final value in CATCH_URLS) {
      //?.为判空操作，如果url为空，直接为false
      if (url?.endsWith(value) ?? false) {
        contain = true;
        break;
      }
    }
    return contain;
  }

  @override
  void dispose() {
    //取消注册的监听
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    _onHttpError.cancel();
    webviewReference.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String statusBarColorStr = widget.statusBarColor ?? 'fffffff';
    Color backButtonColor;
    if (statusBarColorStr == 'ffffff') {
      backButtonColor = Colors.black;
    } else {
      backButtonColor = Colors.white;
    }
    return Scaffold(
      body: Column(
        children: <Widget>[
          //字符串转成int类型的颜色
          _appBar(
              Color(int.parse("0xff" + statusBarColorStr)), backButtonColor),
          //撑满整个页面
          Expanded(child: WebviewScaffold(
            url: widget.url,
            //设置缩放
            withZoom: true,
            //启用本地缓存
            withLocalStorage: true,
            hidden: true,
            //初始化界面(还存在Bug)
            initialChild: Container(
              color: Colors.white,
              child: Center(
                child: Text('Waiting...'),
              ),
            ),))
        ],
      ),
    );
  }

  //自定义AppBar
  _appBar(Color backgroundColor, Color backButtonColor) {
    if (widget.hideAppBar ?? false) {
      //隐藏状态下的AppBar
      return Container(
        color: backgroundColor,
        height: 30,
      );
    } else {
      return Container(
        color: backgroundColor,
        padding: EdgeInsets.fromLTRB(0, 40, 0, 10),
        //使用FractionallySizedBox撑满屏幕的宽度
        child: FractionallySizedBox(
          widthFactor: 1,
          child: Stack( //使用绝对方式布局
            children: <Widget>[
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Icon(
                    Icons.close,
                    color: backButtonColor,
                    size: 26,
                  ),
                ),
              ),
              //绝对定位
              Positioned(child: Center(
                child: Text(widget.title ?? '',
                  style: TextStyle(color: backButtonColor, fontSize: 20),),
              ),
                left: 0,
                right: 0,)
            ],
          ),
        ),
      );
    }
  }

}