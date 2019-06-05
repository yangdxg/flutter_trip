class ConfigModel {
  final String searchUrl;

  //大括号表示构造方法是可选的
  ConfigModel({this.searchUrl});

  factory ConfigModel.fromJson(Map<String, dynamic> json){
    return ConfigModel(searchUrl: json['searchUrl']);
  }

  Map<String, dynamic> toJson() {
    return {searchUrl: searchUrl};
  }

}