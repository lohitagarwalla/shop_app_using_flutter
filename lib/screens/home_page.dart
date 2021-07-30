import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ghs_app/components/network.dart';
import 'package:ghs_app/screens/profile_page.dart';
import 'package:ghs_app/utility-folder/shared-preferences-storage.dart';
import '../components/drawerWidget.dart';
import '../components/productCard.dart';
import '../classes/product.dart';
import '../components/bottomButton.dart';
import '../classes/mySearch.dart';
import 'login_page.dart';
import 'add_product.dart';
import 'package:http/http.dart' as http;
import '../components/constants.dart';
import 'package:loading_overlay/loading_overlay.dart';

const getProduct = endPoint + '/products/get';

List<Product> products = [];

class HomePage extends StatefulWidget {
  const HomePage({Key? key, this.getUrl}) : super(key: key);

  final String? getUrl;

  @override
  _HomePageState createState() => _HomePageState(getUrl: getUrl);
}

class _HomePageState extends State<HomePage> {
  final List<String> kWords;
  var isLogged = false;
  SearchAppBarDelegate _searchDelegate = SearchAppBarDelegate([], []);
  bool isLoading = false;
  String? getUrl;

  //Initializing with sorted list of english words
  _HomePageState({this.getUrl})
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
    updateProductsArray(getUrl ?? getProduct);
    updateIsLogged();
  }

  updateIsLogged() async {
    var token = await getToken();
    if (token == no_token_found) {
      setState(() {
        isLogged = false;
      });
    } else {
      setState(() {
        isLogged = true;
      });
    }
  }

  void updateProductsArray(String url) async {
    setState(() {
      isLoading = true;
    });
    if (url == '') return;
    var returnValue = await getRequest(url);
    List productsarr = [];
    if (returnValue == null) {
      Product errorProduct = Product();
      errorProduct.name = 'some newtork error occured';
      productsarr.add(errorProduct);
      setState(() {
        products = [errorProduct];
      });
    } else {
      http.Response response = returnValue;
      productsarr = parseProduct(response.body);

      setState(() {
        products = productsarr as List<Product>;
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  List<Product> parseProduct(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<Product>((json) => Product.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(context: context, title: 'My App'),
      appBar: AppBar(
        title: Text('Vertex'),
        actions: <Widget>[
          if (isLogged)
            IconButton(
              onPressed: () async {
                var returnProduct = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AddProductPage(product: Product(), title: 'Add Product'
                            // category: 'New Category',
                            ),
                  ),
                );
                if (returnProduct == null) return;
                products.insert(0, returnProduct[0]);
                setState(() {
                  products;
                });
              },
              icon: Icon(Icons.add),
            ),
          IconButton(
            onPressed: () async {
              var searchquery =
                  await showSearch(context: context, delegate: _searchDelegate);
              if (searchquery != '') {
                String searchUrl =
                    endPoint + '/products/search/' + searchquery!;
                updateProductsArray(searchUrl);
              }
            },
            icon: Icon(
              Icons.search,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () async {
              String token = await getToken();
              if (token == no_token_found) {
                var result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoginScreen(
                            title: 'User Login', isLogged: isLogged)));
                if (result) {
                  setState(() {
                    isLogged = true;
                  });
                }
                print(result);
              } else {
                var value = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ProfileScreen(title: 'User Profile')));
                if (value != null) {
                  setState(() {
                    isLogged = false;
                  });
                }
              }
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
      body: LoadingOverlay(
          color: Colors.blue,
          isLoading: isLoading,
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemCount: products.length + 1,
                  itemBuilder: (BuildContext cntxt, int index) {
                    return index == products.length
                        ? BottomButton()
                        : ProductCard(
                            product: products[index],
                            isEditable: isLogged,
                            onDeleted: () {
                              updateProductsArray(getProduct);
                            },
                          );
                  },
                  separatorBuilder: (BuildContext cntxt, int index) {
                    return SizedBox(
                      height: 1,
                    );
                  },
                ),
              ),
            ],
          )),
    );
  }
}
