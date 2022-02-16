import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ghs_app/components/network.dart';
import '../components/drawerWidget.dart';
import '../components/productCard.dart';
import '../classes/product.dart';
import '../components/bottomButton.dart';
import '../classes/mySearch.dart';
// import 'add_product.dart';
import 'package:http/http.dart' as http;
import '../components/constants.dart';
import 'package:loading_overlay/loading_overlay.dart';

const getProduct = endPoint + '/products/get';
const appTitle = 'Alls Good';

List<Product> products = [];

class HomePage extends StatefulWidget {
  const HomePage({Key? key, this.getUrl}) : super(key: key);

  final String? getUrl;

  @override
  _HomePageState createState() => _HomePageState(getUrl: getUrl);
}

class _HomePageState extends State<HomePage> {
  final List<String> kWords;
  // var isLogged = false;
  SearchAppBarDelegate _searchDelegate = SearchAppBarDelegate([], []);
  bool isLoading = false;
  String? getUrl;
  int skip = 0;

  void showMore(String url) async {
    skip += 10;
    var returnValue = await getRequest(url + '?skip=' + skip.toString());
    List productsarr = [];
    if (returnValue == null) {
      // TODO handle in return is null
    } else {
      http.Response response = returnValue;
      productsarr = parseProduct(response.body);

      setState(() {
        products.addAll(productsarr as List<Product>);
      });
    }
  }

  //Initializing with sorted list of english words
  _HomePageState({this.getUrl})
      : kWords = [],
        super();

  @override
  void initState() {
    super.initState();
    _searchDelegate = SearchAppBarDelegate(kWords, []);
    updateProductsArray(getUrl ?? getProduct);
    // updateIsLogged();
  }

  // updateIsLogged() async {
  //   var token = await getToken();
  //   if (token == no_token_found) {
  //     setState(() {
  //       isLogged = false;
  //     });
  //   } else {
  //     setState(() {
  //       isLogged = true;
  //     });
  //   }
  // }

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
    print("responseBody");
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<Product>((json) => Product.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(context: context, title: appTitle),
      appBar: AppBar(
        title: Text(appTitle),
        actions: <Widget>[
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
            icon: Icon(Icons.search, size: 30),
          ),
          SizedBox(width: 15)
        ],
      ),
      body: LoadingOverlay(
          color: Colors.blue,
          isLoading: isLoading,
          child: ListView.builder(
            itemCount: products.length,
            itemBuilder: (BuildContext context, int index) {
              return ProductCard(
                product: products[index],
                onDeleted: () {
                  updateProductsArray(getProduct);
                },
              );
            },
          )),
    );
  }
}
