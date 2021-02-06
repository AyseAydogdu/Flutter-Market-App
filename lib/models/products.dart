class Products {
  int id;
  int categoryId;
  String productName;
  String imageUrl;
  String description;
  double unitPrice;
  Products(this.id, this.categoryId, this.productName, this.imageUrl,
      this.unitPrice);
  List<Products> products = [];
  Products.fromJson(Map json) {
    id = json["id"];
    categoryId = json["categoryId"];
    productName = json["productName"];
    imageUrl = json["imageUrl"];
    description = json["description"];
    unitPrice = double.parse(json["unitPrice"].toString());
  }
  Map toJson() {
    return {
      "id": id,
      "categoryId": categoryId,
      "productName": productName,
      "imageUrl": imageUrl,
      "description": description,
      "unitPrice": unitPrice
    };
  }
}
