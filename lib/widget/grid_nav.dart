import 'package:flutter/material.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';
import 'package:flutter_trip/widget/webview.dart';

/**
 * 不需要交互，只用于纯展示，所以选择StatelessWidget，成员变量必须是final类型的
 */

class GridNavWidget extends StatelessWidget {
  final GridNavModel gridNavModel;

  //@required标识参数是必须的
  GridNavWidget({Key key, @required this.gridNavModel}) :super(key: key);


  @override
  Widget build(BuildContext context) {
    //设置圆角不能使用装饰器，上面的颜色渐变和图片会把圆角盖住
    return PhysicalModel(//实现圆角
        color: Colors.transparent,
        borderRadius: BorderRadius.all(Radius.circular(12)),
        //设置裁切
        clipBehavior: Clip.antiAlias,
        child: Column(
            children: _gridNavItems(context))
    );
  }

  _gridNavItems(BuildContext context) {
    List<Widget> items = [];
    if (gridNavModel == null) return null;
    if (gridNavModel.hotel != null) {
      items.add(_gridNavItem(context, gridNavModel.hotel, true));
    }
    if (gridNavModel.flight != null) {
      items.add(_gridNavItem(context, gridNavModel.flight, false));
    }
    if (gridNavModel.travel != null) {
      items.add(_gridNavItem(context, gridNavModel.travel, false));
    }
    return items;
  }

  _gridNavItem(BuildContext context, GridItemModel gridNavItem, bool first) {
    List<Widget> items = [];
    items.add(_mainItem(context, gridNavItem.mainItem));
    items.add(_doubleItem(context, gridNavItem.item1, gridNavItem.item2, true));
    items.add(
        _doubleItem(context, gridNavItem.item3, gridNavItem.item4, false));
    List<Expanded> expandItems = [];
    items.forEach((item) {
      expandItems.add(Expanded(child: item, flex: 1,),);
    });
    Color startColor = Color(int.parse("0xff" + gridNavItem.startColor));
    Color endColor = Color(int.parse("0xff" + gridNavItem.endColor));
    return Container(
      height: 88,
      margin: first ? null : EdgeInsets.only(top: 3),
      decoration: BoxDecoration(
        //线形渐变
          gradient: LinearGradient(colors: [startColor, endColor])
      ),
      child: Row(children: expandItems,),
    );
  }

  _mainItem(BuildContext context, CommonModel model) {
    return _wrapGesture(context, Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Image.network(model.icon, fit: BoxFit.contain,
          height: 88,
          width: 121,
          alignment: AlignmentDirectional.bottomEnd,),
        Container(
          margin: EdgeInsets.only(top: 11),
          child: Text(model.title,
            style: TextStyle(fontSize: 14, color: Colors.white),),
        )
      ],
    ), model);
  }

  _doubleItem(BuildContext context, CommonModel topItem,
      CommonModel bottomItem, bool isCenterItem) {
    return Column(
      children: <Widget>[
        //垂直方向展开
        Expanded(
          child: _item(context, topItem, true, isCenterItem),
        ),
        Expanded(
          child: _item(context, topItem, true, isCenterItem),
        )
      ],
    );
  }

  _item(BuildContext context, CommonModel model, bool first, bool isCenter) {
    BorderSide borderSide = BorderSide(width: 0.8, color: Colors.white);
    return FractionallySizedBox(
      //宽度撑满父布局
      widthFactor: 1,
      child: Container(
        //设置装饰器
          decoration: BoxDecoration(
              border: Border(
                left: borderSide,
                bottom: first ? borderSide : BorderSide.none,
              )
          ),
          child: _wrapGesture(context, Center(
            child: Text(model.title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, color: Colors.white),),
          ), model)
      ),
    );
  }

  _wrapGesture(BuildContext context, Widget widget, CommonModel model) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
            WebViewWidget(
              url: model.url,
              statusBarColor: model.statusBarColor,
              title: model.title,
              hideAppBar: model.hideAppBar,
            )));
      },
      child: widget,
    );
  }
}