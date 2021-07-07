import 'package:flutter/material.dart';
import 'components/DrawerWidget.dart';
import 'components/productCard.dart';
import 'components/product.dart';
import 'components/bottomButton.dart';
import 'mySearch.dart';
import 'components/login_page.dart';
import 'components/add_product.dart';

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

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> kWords;
  var isLogged = true;
  SearchAppBarDelegate _searchDelegate = SearchAppBarDelegate([], []);

  //Initializing with sorted list of english words
  _HomePageState()
      : kWords = [
          'hello',
          'dear',
          'friend',
          'how',
          'are',
          'you',
          'lets',
          'meet',
          'soon'
        ]..sort(
            (w1, w2) => w1.toLowerCase().compareTo(w2.toLowerCase()),
          ),
        super();

  @override
  void initState() {
    super.initState();
    _searchDelegate = SearchAppBarDelegate(kWords, []);
  }

  @override
  Widget build(BuildContext context) {
    final List<String> category = ['Laptop', 'Mouse', 'Settings'];
    return Scaffold(
      drawer: DrawerWidget(category: category),
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.account_circle),
            Text('my_app'),
          ],
        ),
        actions: <Widget>[
          if (isLogged)
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddProductPage(),
                  ),
                );
              },
              icon: Icon(Icons.add),
            ),
          IconButton(
            onPressed: () async {
              String? x =
                  await showSearch(context: context, delegate: _searchDelegate);
              print(x);
            },
            icon: Icon(
              Icons.search,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
              // print('Login icon pressed');
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
