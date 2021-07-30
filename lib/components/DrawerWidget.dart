import 'package:flutter/material.dart';
import 'package:ghs_app/classes/category.dart';
import 'package:ghs_app/screens/showCategory.dart';

Category hello1 = Category(name: 'hello1', subCategories: []);
Category hello2 = Category(name: 'hello2', subCategories: []);
Category hello3 = Category(name: 'hello3', subCategories: []);

void initializeCategory() {
  hello1.subCategories!.add(hello2);
  hello1.subCategories!.add(hello3);
  hello1.subCategories!.add(hello2);
  hello1.subCategories!.add(hello3);
  hello1.subCategories!.add(hello2);
  hello1.subCategories!.add(hello3);
}

class DrawerWidget extends StatelessWidget {
  final String name = 'Lohit Agarwalla';
  final String email = 'lohitagarwalla@gmail.com';
  final String title;
  final BuildContext context;

  const DrawerWidget({Key? key, required this.context, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: createDynamicListView(),
      ),
    );
  }

  List<Widget> createDynamicListView() {
    List<Widget> children = [];
    children
      ..addAll(headers())
      ..addAll(options())
      ..addAll([Divider()])
      ..addAll(settings());
    return children;
  }

  List<Widget> headers() {
    List<Widget> children = [];
    children.add(Container(
      padding: EdgeInsets.all(16),
      height: 100,
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(fontSize: 25, color: Colors.white),
      ),
      decoration: BoxDecoration(color: Colors.blue),
    ));
    return children;
  }

  List<Widget> options() {
    initializeCategory();
    List<Widget> children = [];
    children.add(ListTile(
      title: Text('Shop by Category'),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ShowCategory()),
        );
      },
    ));
    return children;
  }

  List<Widget> settings() {
    List<Widget> children = [];
    children.add(ListTile(title: Text('Seller Account')));
    children.add(ListTile(title: Text('Settings')));
    return children;
  }
}
