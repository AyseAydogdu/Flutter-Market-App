class Categories {
  int id;
  String categoryName;
  String imageUrl;
  List<Categories> categories = [];
  Categories({this.id, this.categoryName, this.imageUrl});
  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(
        id: json['id'],
        categoryName: json['categoryName'],
        imageUrl: json["imageUrl"]);
  }
  Map toJson() {
    return {
      "id": id,
      "categoryName": categoryName,
      "imageUrl": imageUrl,
    };
  }
}
