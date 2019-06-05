import 'package:flutter/material.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/widget/webview.dart';

class LocalNavWidget extends StatelessWidget {

  final List<CommonModel> localNavList;


  LocalNavWidget({Key key, @required this.localNavList}) :super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      //设置装饰器
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      child: Padding(padding: EdgeInsets.all(7),
        child: _items(context),
      ),
    );
  }

  _items(BuildContext context) {
    if (localNavList == null) return null;
    List<Widget> items = [];
    localNavList.forEach((model) {
      items.add(_item(context, model));
    });
    return Row(
      //排列方式，spaceAround平均排列
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: items,
    );
  }

  Widget _item(BuildContext context, CommonModel model) {
    //为组件添加点击效果，可以使用GestureDetector包裹这个组件
    return GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) =>
                  WebViewWidget(url: model.url,
                    statusBarColor: model.statusBarColor,
                    hideAppBar: model.hideAppBar,
                  )));
        },
        child: Column(
          children: <Widget>[
            Image.network(model.icon,
                width: 32,
                height: 32),
            Text(model.title, style: TextStyle(fontSize: 12),)
          ],
        )
    );
  }

}