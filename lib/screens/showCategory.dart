import 'package:flutter/material.dart';
import 'package:ghs_app/classes/category.dart';
import 'package:ghs_app/utility-folder/utility.dart';

Category hello1 = Category(name: 'hello1', subCategories: []);
Category hello2 = Category(name: 'hello2', subCategories: []);
Category hello3 = Category(name: 'hello3', subCategories: []);

class ShowCategory extends StatefulWidget {
  const ShowCategory({Key? key, required this.category}) : super(key: key);

  final Category category;

  @override
  _ShowCategoryState createState() => _ShowCategoryState(category: category);
}

class _ShowCategoryState extends State<ShowCategory> {
  int categoryCount = 0;

  final Category category;

  _ShowCategoryState({required this.category});

  void initializeCategory() {
    hello1.subCategories!.add(hello2);
    hello1.subCategories!.add(hello3);
  }

  @override
  void initState() {
    // initializeCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(category.subCategories!.length);
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop by category'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: category.subCategories!.length,
        itemBuilder: (BuildContext context, int index) {
          return categoryCard(index);
        },
      ),
    );
  }

  Widget categoryCard(int index) {
    return GestureDetector(
      onTap: () {
        for (int i = 0; i <= index; i++) {
          initializeCategory();
        }
        ShowSnackBar(context, Text(category.subCategories![index].name!));
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ShowCategory(
                    category: hello1,
                  )),
        );
      },
      child: Container(
        child: Center(
          child: Text(category.subCategories![index].name!),
        ),
        margin: EdgeInsets.all(8),
        height: 100,
        decoration: BoxDecoration(color: Color(0x09000000)),
      ),
    );
  }
}
