class ProductModel {
  String? id;
  String? categoryId;
  String? name;
  int? rate;
  String? image;
  dynamic? currentPrice;
  dynamic? oldPrice;
  String? description;
  String? timeDiscount;
  int? discount;
  List<String>? colors;
  List<String>? sizes;

  ProductModel({
    this.id,
    this.categoryId,
    this.name,
    this.rate,
    this.currentPrice,
    this.timeDiscount,
    this.image,
    this.oldPrice,
    this.description,
    this.discount,
    this.colors,
    this.sizes,
  });

  ProductModel.fromJson(Map<String, dynamic>? json) {
    id = json!['id'];
    categoryId = json['categoryId'];
    name = json['name'];
    rate = json['rate'];
    currentPrice = json['currentPrice'];
    oldPrice = json['oldPrice'];
    image = json['image'];
    description = json['description'];
    timeDiscount = json['timeDiscount'];
    discount = json['discount'];
    colors = json["colors"] == null
        ? []
        : List<String>.from(json["colors"].map((x) => x));
    sizes = json["sizes"] == null
        ? []
        : List<String>.from(json["sizes"].map((x) => x));
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'categoryId': categoryId,
      'name': name,
      'rate': rate,
      'currentPrice': currentPrice,
      'oldPrice': oldPrice,
      'image': image,
      'description': description,
      'discount': discount,
      'timeDiscount': timeDiscount,
      'colors': colors,
      'sizes': sizes,
    };
  }
}
