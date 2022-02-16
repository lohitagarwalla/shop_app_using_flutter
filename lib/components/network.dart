import 'dart:convert';
import 'package:ghs_app/classes/product.dart';
// import 'package:ghs_app/classes/seller.dart';
import 'package:ghs_app/classes/user.dart';
import 'package:http/http.dart' as http;

Future<http.Response> productCreateOrUpdateRequest(
    String url, Product newProduct, Function func) {
  var body = jsonEncode(<String, dynamic>{
    "price": newProduct.getprice(),
    "imageString": newProduct.getimageString(),
    "name": newProduct.getname(),
    "description": newProduct.getdescription(),
    "category": newProduct.getCategory(),
    "itemNo": newProduct.getitemNo(),
  });
  return func(url, body); //func can be patchRequest of postRequest
}

Future<http.Response> userCreateOrLoginRequest(String url) {
  var body = jsonEncode(<String, dynamic>{
    "name": User.name,
    "email": User.email,
    "pass": User.pass
  });
  return postRequest(url, body);
}

// Future<http.Response> sellerCreateOrLoginRequest(String url, Seller seller) {
//   var body = jsonEncode(<String, dynamic>{
//     "companyName": seller.getCompanyName(),
//     "name": seller.getname(),
//     "email": seller.getemail(),
//     "phone": seller.getPhone(),
//     "pass": seller.getPass()
//   });
//   return postRequest(url, body);
// }

Future<http.Response> postRequest(String url, String jsonString) async {
  http.Response response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonString,
  );
  return response;
}

Future<http.Response> patchRequest(String url, String jsonString) async {
  http.Response response = await http.patch(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonString,
  );
  return response;
}

Future<dynamic> getRequest(String url) async {
  var getUrl = Uri.parse(url);
  print(getUrl);
  try {
    http.Response response = await http.get(getUrl);
    print(response.statusCode);
    if (response.statusCode == 200)
      return response;
    else
      throw Error();
  } catch (e) {
    print("Hello fail");
    return null;
  }
}

Future<http.Response> deleteRequest(String url) async {
  final http.Response response = await http.delete(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  return response;
}
