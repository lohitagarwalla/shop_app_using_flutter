import 'package:flutter/material.dart';
import 'components/DrawerWidget.dart';
import 'components/productCard.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.account_circle),
            Text('my_app'),
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          ProductCard(
            imageUrl: 'https://picsum.photos/250?image=9',
            productName: 'Apple Laptop',
            itemNo: 554,
            desctiption:
                'Steel water tap Description: Steel water tap Description: Steel water tap',
            category: 'Laptop',
          ),
          ProductCard(
            imageUrl: 'https://picsum.photos/250?image=9',
            productName: 'Apple Laptop',
            itemNo: 554,
            desctiption:
                'Steel water tap Description: Steel water tap Description: Steel water tap',
          ),
          ProductCard(
            imageUrl: 'https://picsum.photos/250?image=9',
            productName: 'Apple Laptop',
            itemNo: 554,
            desctiption:
                'Steel water tap Description: Steel water tap Description: Steel water tap',
          ),
        ],
      ),
    );
  }
}
