import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  DrawerWidget({required this.category});
  final List<String> category;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: category.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return new ListTile(
            title: Text(category[index]),
            onTap: () {
              Navigator.of(context).pop();
              print('ListTile is pressed');
            },
          );
        },
      ),
    );
  }
}
