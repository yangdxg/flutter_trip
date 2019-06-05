import 'package:flutter/material.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/widget/webview.dart';

class SubNavWidget extends StatelessWidget {

  final List<CommonModel> subNavList;

  SubNavWidget({Key key, this.subNavList}) :super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5)
      ),
      child: Padding(
        padding: EdgeInsets.all(7),
        child: _items(context),)
      ,
    );
  }

  _items(BuildContext context) {
    if (subNavList == null) return null;
    List<Widget> items = [];
    int separate = (subNavList.length / 2 + 0.5).toInt();
    subNavList.forEach((model) {
      items.add(_item(context, model));
    });
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: items.sublist(0, separate),
        ),
        Padding(padding: EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: items.sublist(separate, items.length),
          ),)

      ],
    );
  }

  Widget _item(BuildContext context, CommonModel model) {
    //为组件添加点击效果，可以使用GestureDetector包裹这个组件
    return Expanded(child: GestureDetector(
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
                width: 18,
                height: 18),
            Padding(padding: EdgeInsets.only(top: 3),
              child: Text(model.title, style: TextStyle(fontSize: 12),),)
          ],
        )
    ));
  }

}