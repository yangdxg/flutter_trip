import 'package:flutter/material.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/sales_box_model.dart';
import 'package:flutter_trip/widget/webview.dart';

/**
 * 底部卡片入口
 */
class SalesBoxWidget extends StatelessWidget {

  final SalesBoxModel salesBoxList;

  SalesBoxWidget({Key key, this.salesBoxList}) :super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5)
      ),
      child: _items(context),
    );
  }

  _items(BuildContext context) {
    if (salesBoxList == null) return null;
    List<Widget> items = [];
    items.add(_doubleItem(
        context, salesBoxList.bigCard1, salesBoxList.bigCard2, true, false));
    items.add(_doubleItem(
        context, salesBoxList.smallCard1, salesBoxList.smallCard2, false,
        false));
    items.add(_doubleItem(
        context, salesBoxList.smallCard3, salesBoxList.smallCard4, false,
        false));

    return Column(
      children: <Widget>[
        Container(
          height: 44,
          margin: EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: 1, color: Color(0xffff2f2f2)))
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image.network(salesBoxList.icon, height: 15, fit: BoxFit.fill,),
              Container(
                padding: EdgeInsets.fromLTRB(10, 1, 8, 1),
                margin: EdgeInsets.only(right: 7),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                        colors: [Color(0xffff4e63), Color(0xffff6cc9)],
                        begin: Alignment.centerLeft, end: Alignment.centerRight)
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) =>
                        WebViewWidget(url: salesBoxList.moreUrl, title: "更多活动",)
                    ));
                  },
                  child: Text('获取更多福利>',
                    style: TextStyle(color: Colors.white, fontSize: 12),),
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: items.sublist(0, 1),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: items.sublist(1, 2),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: items.sublist(2, 3),
        ),
      ],
    );
  }

  Widget _doubleItem(BuildContext context, CommonModel leftCard,
      CommonModel rightCard, bool big, bool last) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _item(context, leftCard, big, true, false),
        _item(context, rightCard, big, true, true),
      ],
    );
  }

  Widget _item(BuildContext context, CommonModel model, bool big, bool left,
      bool last) {
    //为组件添加点击效果，可以使用GestureDetector包裹这个组件
    BorderSide borderSide = BorderSide(width: 0.8, color: Color(0xfff2f2f2));
    return GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) =>
                  WebViewWidget(url: model.url,
                    statusBarColor: model.statusBarColor,
                    hideAppBar: model.hideAppBar,
                  )));
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border(right: left ? borderSide : BorderSide.none,
                  bottom: last ? BorderSide.none : borderSide)
          ),
          child:
          Image.network(model.icon,
              fit: BoxFit.fill,
              //屏幕宽度
              width: MediaQuery
                  .of(context)
                  .size
                  .width / 2 - 10,
              height: big ? 129 : 80),
        ));
  }


}