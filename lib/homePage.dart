import 'package:flutter/material.dart';
import 'components/DrawerWidget.dart';
import 'components/productCard.dart';
import 'components/product.dart';
import 'components/bottomButton.dart';

List<Product> products = [
  Product(
      imageUrl: 'https://picsum.photos/250?image=9',
      name: 'Apple Laptop',
      itemNo: 554,
      description:
          'Steel water tap Description: Steel water tap Description: Steel water tap Steel water tap Description: Steel water tap Description: Steel water tap Steel water tap Description: Steel water tap Description: Steel water tap Steel water tap Description: Steel water tap Description: Steel water tap Steel water tap Description: Steel water tap Description: Steel water tap Steel water tap Description: Steel water tap Description: Steel water tap Steel water tap Description: Steel water tap Description: Steel water tap Steel water tap Description: Steel water tap Description: Steel water tap',
      category: 'laptop'),
  Product(
      imageUrl:
          'https://images.unsplash.com/photo-1625476255174-4db21bc943ea?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80',
      name: 'HP Mouse',
      itemNo: 555,
      description: 'Computer mouse. USB connection. Good grip.',
      category: 'laptop'),
  Product(
      imageUrl: 'https://picsum.photos/250?image=9',
      name: 'Apple Laptop',
      itemNo: 556,
      description: 'Steel water tap',
      category: 'laptop'),
];

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> category = ['Laptop', 'Mouse', 'Settings'];
    return Scaffold(
      drawer: DrawerWidget(category: category),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              print('search icon pressed');
            },
            icon: Icon(
              Icons.search,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () {
              print('Login icon pressed');
            },
            icon: Icon(
              Icons.person,
              size: 30,
            ),
          ),
          SizedBox(
            width: 15,
          )
        ],
        title: Row(
          children: [
            Icon(Icons.account_circle),
            Text('my_app'),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: products.length + 1,
              itemBuilder: (BuildContext cntxt, int index) {
                return index == products.length
                    ? BottomButton()
                    : ProductCard(
                        imageUrl: products[index].getimageUrl(),
                        productName: products[index].getname(),
                        itemNo: products[index].getitemNo(),
                        desctiption: products[index].getdescription(),
                        category: products[index].getcategory(),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
