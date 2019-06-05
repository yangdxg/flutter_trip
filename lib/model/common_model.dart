class CommonModel {
  final String icon;
  final String url;
  final String title;
  final String statusBarColor;
  final bool hideAppBar;

  //大括号表示构造方法是可选的
  CommonModel(
      {this.title, this.statusBarColor, this.hideAppBar, this.icon, this.url});

  factory CommonModel.fromJson(Map<String, dynamic> json){
    return CommonModel(icon: json['icon'],
        url: json['url'],
        title: json['title'],
        statusBarColor: json['statusBarColor'],
        hideAppBar: json['hideAppBar']);
  }
}