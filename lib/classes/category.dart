// class Category {
//   String? name = '';
//   List<Category>? subCategories = [];

//   Category(
//       {required this.name,
//       required this.subCategories,
//       Category? subCategory}) {
//     if (subCategory != null) {
//       this.subCategories!.add(subCategory);
//     }
//   }

//   factory Category.fromJson(Map<String, dynamic> parsedJson) {
//     var list = parsedJson['values'] as List;
//     List<Category> categoryList =
//         list.map((i) => Category.fromJson(i)).toList();

//     return Category(name: parsedJson['name'], subCategories: categoryList);
//   }

//   Map toJson() {
//     List<Map>? subcategories = this.subCategories != null
//         ? this.subCategories!.map((i) => i.toJson()).toList()
//         : null;
//     return {'name': name, 'subCategories': subcategories};
//   }
// }
