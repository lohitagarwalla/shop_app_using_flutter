class Product {
  String imageUrl;
  String name;
  int itemNo;
  String description;
  String category;

  Product(
      {this.imageUrl = '',
      this.name = '',
      this.itemNo = 0,
      this.description = '',
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

  String getcategory() {
    return category;
  }
}
