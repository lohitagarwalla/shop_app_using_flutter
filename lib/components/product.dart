class Product {
  String imageUrl;
  String name;
  int itemNo;
  String description;
  int price;
  String category;

  Product(
      {this.imageUrl = '',
      this.name = '',
      this.itemNo = 0,
      this.description = '',
      this.price = 0,
      this.category = ''});

  String getimageUrl() {
    return imageUrl;
  }

  String getname() {
    return name;
  }

  int getitemNo() {
    return itemNo;
  }

  String getdescription() {
    return description;
  }

  int getprice() {
    return price;
  }

  String getCategory() {
    return category;
  }
}
