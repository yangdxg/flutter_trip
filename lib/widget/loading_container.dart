import 'package:flutter/material.dart';

/**
 * 加载进度条组件
 */
class LoadingContainer extends StatelessWidget {
  //加载完后呈现的内容
  final Widget child;

  //组件的状态
  final bool isLoading;

  //是否要覆盖整个页面的额布局
  final bool cover;


  LoadingContainer(
      {Key key, @required this.child, this.isLoading, this.cover = false});

  @override
  Widget build(BuildContext context) {
    return !cover ? !isLoading ? child : _loadingView : Stack(
      children: <Widget>[
        child,
        isLoading ? _loadingView : null
      ],
    );
  }

  Widget get _loadingView {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

}