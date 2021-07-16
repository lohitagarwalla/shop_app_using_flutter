import 'dart:convert';
import 'package:flutter/material.dart';
import '../components/DrawerWidget.dart';
import '../components/productCard.dart';
import '../components/product.dart';
import '../components/bottomButton.dart';
import '../components/mySearch.dart';
import 'login_page.dart';
import 'add_product.dart';
import 'package:http/http.dart' as http;
import '../components/constants.dart';

const getProduct = endPoint + '/products/get';

List<Product> products = [];

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
    updateProductsArray(getProduct);
    print('home page init called');
  }

  updateProductsArray(String url) async {
    var getUrl = Uri.parse(url);
    http.Response response = await http.get(getUrl);
    List productsarr = parseProduct(response.body);

    setState(() {
      products = productsarr as List<Product>;
      print(productsarr);
    });
  }

  List<Product> parseProduct(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<Product>((json) => Product.fromJson(json)).toList();
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
            SizedBox(
              width: 10,
            ),
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
                    builder: (context) => AddProductPage(
                      product: Product(),
                      // category: 'New Category',
                    ),
                  ),
                );
              },
              icon: Icon(Icons.add),
            ),
          IconButton(
            onPressed: () async {
              updateProductsArray(getProduct);
              // String? x =
              //     await showSearch(context: context, delegate: _searchDelegate);
              // print(x);
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
                        product: products[index],
                        isEditable: isLogged,
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
