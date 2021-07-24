class Product {
  String? imageString;
  String? name;
  int? itemNo;
  String? description;
  int? price;
  String? category;

  Product(
      {this.imageString = '',
      this.name = '',
      this.itemNo = 0,
      this.description = '',
      this.price = 0,
      this.category = ''});

  String getimageString() {
    return imageString ?? '';
  }

  String getname() {
    return name ?? '';
  }

  int getitemNo() {
    return itemNo ?? 0;
  }

  String getdescription() {
    return description ?? '';
  }

  int getprice() {
    return price ?? 0;
  }

  String getCategory() {
    return category ?? '';
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      imageString: json['imageString'],
      name: json['name'] as String,
      itemNo: json['itemNo'],
      description: json['description'] as String,
      price: json['price'] as int,
      category: json['category'] as String,
    );
  }
}
