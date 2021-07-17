import 'dart:convert';
import 'package:ghs_app/components/product.dart';
import 'package:http/http.dart' as http;

Future<http.Response> createProduct(String url, Product newproduct) {
  var body = jsonEncode(<String, dynamic>{
    "price": newproduct.getprice(),
    "imageString": newproduct.getimageString(),
    "name": newproduct.getname(),
    "description": newproduct.getdescription(),
    "category": newproduct.getCategory(),
    "itemNo": newproduct.getitemNo(),
  });
  return postRequest(url, body);
}

Future<http.Response> postRequest(String url, String jsonString) {
  return http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonString,
  );
}

Future<dynamic> getRequest(String url) async {
  var getUrl = Uri.parse(url);
  print(getUrl);
  try {
    http.Response response = await http.get(getUrl);
    if (response.statusCode == 200)
      return response;
    else
      throw Error();
  } catch (e) {
    return null;
  }
}
