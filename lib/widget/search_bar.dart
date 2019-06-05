import 'package:flutter/material.dart';

enum SearchBarType {
  home,
  normal,
  homeLight
}

class SearchBar extends StatefulWidget {

  final bool enable; //禁止搜索
  final bool hideLeft; //左边返回是否隐藏
  final SearchBarType searchBarType; //类型
  final String hint; //提示
  final String defaultText; //默认文字
  final void Function() leftButtonClick;
  final void Function() rightButtonClick;
  final void Function() speckClick;
  final void Function() inputBoxClick;
  final ValueChanged<String> onChanged; //内容变化

  const SearchBar(
      {this.enable = true, this.hideLeft, this.searchBarType = SearchBarType
          .normal, this.hint,
        this.defaultText, this.leftButtonClick, this.rightButtonClick,
        this.speckClick, this.inputBoxClick, this.onChanged});

  @override
  SearchBarState createState() => SearchBarState();

}

class SearchBarState extends State<SearchBar> {

  bool showClear = false; //是否显示清除按钮
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    if (widget.defaultText != null) {
      setState(() {
        controller.text = widget.defaultText;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.searchBarType == SearchBarType.normal
        ? _genNormalSearch()
        : _genHomeSearch();
  }

  _genHomeSearch() {
    return Container(
      child: Row(
        children: <Widget>[
          _wrapTap(Container(
              padding: EdgeInsets.fromLTRB(6, 5, 10, 5),
              child: Row(
                children: <Widget>[
                  Text('上海',
                    style: TextStyle(color: _homeFontColor(), fontSize: 14),),
                  Icon(Icons.expand_more, color: _homeFontColor(), size: 22,)
                ],
              )
          ), widget.leftButtonClick),
          Expanded(
              flex: 1,
              child: _inputBox()),
          _wrapTap(
              Container(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Icon(
                  Icons.comment,
                  color: _homeFontColor(),
                  size: 26,
                ),
              ), widget.rightButtonClick)
        ],
      ),
    );
  }

  _genNormalSearch() {
    return Container(
      child: Row(
        children: <Widget>[
          _wrapTap(Container(
            padding: EdgeInsets.fromLTRB(6, 5, 10, 5),
            child: widget?.hideLeft ?? false ? null : Icon(Icons.arrow_back_ios,
              color: Colors.grey,
              size: 26,),
          ), widget.leftButtonClick),
          Expanded(
              flex: 1,
              child: _inputBox()),
          _wrapTap(
              Container(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Text(
                  '搜索',
                  style: TextStyle(color: Colors.blue, fontSize: 17),
                ),
              ), widget.rightButtonClick)
        ],
      ),
    );
  }

  _wrapTap(Widget child, void Function() callback) {
    return GestureDetector(
      child: child,
      onTap: () {
        if (callback != null) {
          callback();
        }
      },
    );
  }

  _inputBox() {
    Color inputBoxColor;
    if (widget.searchBarType == SearchBarType.home) {
      inputBoxColor = Colors.white;
    } else {
      inputBoxColor = Color(int.parse('0xffEDEDED'));
    }
    return Container(
      height: 30,
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
          color: inputBoxColor,
          borderRadius: BorderRadius.circular(
              widget.searchBarType == SearchBarType.normal ? 5 : 15
          )
      ),
      child: Row(
          children: <Widget>[
            Icon(
              Icons.search,
              size: 20,
              color: widget.searchBarType == SearchBarType.normal ? Color(
                  0xffa9a9a9) : Colors.blue,
            ),
            Expanded(
                flex: 1,
                child: widget.searchBarType == SearchBarType.normal ? TextField(
                  controller: controller,
                  onChanged: _onChange,
                  autofocus: true,
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w300
                  ),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                      border: InputBorder.none,
                      hintText: widget.hint ?? '',
                      hintStyle: TextStyle(fontSize: 15)
                  ),
                ) : _wrapTap(Text(
                  widget.defaultText,
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ), widget.inputBoxClick)
            ),
            !showClear ? _wrapTap(Icon(
              Icons.mic,
              size: 22,
              color: widget.searchBarType == SearchBarType.normal
                  ? Colors.blue
                  : Colors.grey,
            ), widget.speckClick) : _wrapTap(
                Icon(Icons.clear, size: 22, color: Colors.grey,), () {
              controller.clear();
            })
          ]
      )
      ,
    );
  }


  void _onChange(String text) {
    if (text.length > 0) {
      setState(() {
        showClear = true;
      });
    } else {
      setState(() {
        showClear = false;
      });
    }
    if (widget.onChanged != null) {
      widget.onChanged(text);
    }
  }

  _homeFontColor() {
    return widget.searchBarType == SearchBarType.homeLight
        ? Colors.black
        : Colors.white;
  }
}