import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  DrawerWidget({required this.category});
  final List<String> category;
  final String name = 'Lohit Agarwalla';
  final String email = 'lohitagarwalla@gmail.com';

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
    children.add(
      UserAccountsDrawerHeader(
        accountName: Text('Lohit Agarwalla'),
        accountEmail: Text('lohitagarwalla@gmail.com'),
      ),
    );
    return children;
  }

  List<Widget> settings() {
    List<Widget> children = [];
    children.add(ListTile(title: Text('Logout')));
    return children;
  }

  List<Widget> options() {
    List<Widget> children = [];
    category.forEach((element) {
      children.add(ListTile(title: Text(element)));
    });
    return children;
  }
}
