import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/config_model.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';
import 'package:flutter_trip/model/sales_box_model.dart';


class HomeModel {
  final ConfigModel config;
  final List<CommonModel> bannerList;
  final List<CommonModel> localNavList;
  final GridNavModel gridNav;
  final List<CommonModel> subNavList;
  final SalesBoxModel salesBox;

  HomeModel(
      {this.config, this.bannerList, this.localNavList, this.gridNav, this.subNavList, this.salesBox});

  factory HomeModel.fromJson(Map<String, dynamic> json){
    return HomeModel(config: ConfigModel.fromJson(json['config']),
        bannerList: (json['bannerList'] as List).map((i) =>
            CommonModel.fromJson(i)).toList(),
        localNavList: (json['localNavList'] as List).map((i) =>
            CommonModel.fromJson(i)).toList(),
        gridNav: GridNavModel.fromJson(json['gridNav']),
        subNavList: (json['subNavList'] as List).map((i) =>
            CommonModel.fromJson(i)).toList(),
        salesBox: SalesBoxModel.fromJson(json['salesBox'])
    );
  }

/**
 * 如果需要转换成字符串，Android中的toString方法，需要实现toJson方法
 * ConfigModel中有实现该方法
 */
}

