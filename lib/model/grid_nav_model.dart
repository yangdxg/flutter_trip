import 'common_model.dart';

/**
 * 首页网格卡片
 */
class GridNavModel {
  final GridItemModel hotel;
  final GridItemModel flight;
  final GridItemModel travel;

  GridNavModel({this.hotel, this.flight, this.travel});

  factory GridNavModel.fromJson(Map<String, dynamic> json){
    return GridNavModel(hotel: GridItemModel.fromJson(json['hotel']),
        flight: GridItemModel.fromJson(json['flight']),
        travel: GridItemModel.fromJson(json['travel']));
  }
}

class GridItemModel {
  final String startColor;
  final String endColor;
  final CommonModel mainItem;
  final CommonModel item1;
  final CommonModel item2;
  final CommonModel item3;
  final CommonModel item4;

  GridItemModel({this.startColor, this.endColor, this.mainItem, this.item1,
    this.item2, this.item3, this.item4});

  factory GridItemModel.fromJson(Map<String, dynamic> json){
    return GridItemModel(startColor: json['startColor'],
        endColor: json['endColor'],
        mainItem: CommonModel.fromJson(json['mainItem']),
        item1: CommonModel.fromJson(json['item1']),
        item2: CommonModel.fromJson(json['item2']),
        item3: CommonModel.fromJson(json['item3']),
        item4: CommonModel.fromJson(json['item4']));
  }

}