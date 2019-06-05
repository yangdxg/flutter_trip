import 'dart:async';
import 'dart:convert';
import 'package:flutter_trip/model/home_model.dart';
import 'package:http/http.dart' as http;

const HOME_URL = 'http://www.devio.org/io/flutter_app/json/home_page.json';

/**
 * 首页大接口
 * 重点：
 *  1.解决中文乱码
 *  2.首页调用可以通过async await调用也可以使用then方法
 */
class HomeDao {
  static Future<HomeModel> fetch() async {
    final response = await http.get(HOME_URL);
    print("请求");
    if (response.statusCode == 200) {
      //解决http中乱码(修复中文乱码)
      Utf8Decoder utf8decoder = Utf8Decoder();
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return HomeModel.fromJson(result);
    }else{
      print("请求失败");
      throw Exception('加载HomeJson失败');
    }
  }
}