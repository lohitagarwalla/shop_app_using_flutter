import 'package:flutter/material.dart';
import 'package:ghs_app/classes/category.dart';
import 'dart:convert';

void hello() {
  Category hello1 = Category(name: 'hello1', subCategories: []);
  Category hello2 = Category(name: 'hello2', subCategories: []);
  Category hello3 = Category(name: 'hello3', subCategories: []);

  hello1.subCategories!.add(hello2);
  hello1.subCategories!.add(hello3);

  var body = jsonEncode(hello1);
  print(body);
}

class BottomButton extends StatelessWidget {
  const BottomButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: Text('Show More'),
        onPressed: () {
          hello();
        },
      ),
    );
  }
}
