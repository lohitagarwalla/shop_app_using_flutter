import 'package:shared_preferences/shared_preferences.dart';

const String tokenKey = 'tokenKey';
const String no_token_found = "no token found";

Future<bool> saveToken(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool result = await prefs.setString(tokenKey, token);
  return result;
}

Future<String> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString(tokenKey);
  return token ?? no_token_found;
}

Future<bool> removeToken(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool result = await prefs.remove(tokenKey);
  return result;
}
