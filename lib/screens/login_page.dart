import 'package:flutter/material.dart';
import 'package:ghs_app/classes/user.dart';
import 'package:ghs_app/components/constants.dart';
import 'package:ghs_app/components/network.dart';
import 'package:ghs_app/screens/signUp_page.dart';
import 'package:ghs_app/utility-folder/utility.dart';
import 'package:http/http.dart' as http;
import 'package:loading_overlay/loading_overlay.dart';

const String loginUrl = endPoint + '/users/login';
String userEmail = "";

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key, required this.title, required this.isLogged})
      : super(key: key);

  final String title;
  final bool isLogged;

  @override
  _LoginScreenState createState() =>
      _LoginScreenState(title: title, isLogged: isLogged);
}

class _LoginScreenState extends State<LoginScreen> {
  _LoginScreenState({required this.title, required this.isLogged});

  final String title;
  final bool isLogged;

  final _loginEmailControl = TextEditingController();
  final _loginPassControl = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    _loginEmailControl.dispose();
    _loginPassControl.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: LoadingOverlay(
        isLoading: isLoading,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: _loginEmailControl,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      hintText: 'Enter valid email id as abc@gmail.com'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextField(
                  controller: _loginPassControl,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Enter secure password'),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      await userLogin();
                      // if (title.toLowerCase() == 'user login') {
                      //   await userLogin();
                      // } else {
                      //   await sellerLogin();
                      // }

                      setState(() {
                        isLoading = false;
                      });
                    },
                    child: Text('Login'),
                  ),
                  OutlinedButton(
                      onPressed: null, child: Text('Forgot Password'))
                ],
              ),
              Divider(height: 100, thickness: 1),
              Text('Dont have an account?'),
              SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SignUpPage(title: 'User Sign Up')));
                  },
                  child: Text('Sign up')),
            ],
          ),
        ),
      ),
    );
  }

  Future<http.Response> userLogin() async {
    User.email = _loginEmailControl.text;
    User.pass = _loginPassControl.text;

    http.Response res = await userCreateOrLoginRequest(loginUrl);
    // String token = res.body; //todo save token in shared preferences

    // saveToken(token);

    if (res.statusCode == no_such_user) {
      ShowSnackBar(context, Text('Invalid email'));
    } else if (res.statusCode == login_unsuccessfull) {
      ShowSnackBar(context, Text('Login unsuccessfull'));
    } else if (res.statusCode == 200) {
      ShowSnackBar(context, Text('Login successfull'));
      Navigator.pop(context, true);
    } else {
      ShowSnackBar(context, Text('Some Error occured'));
    }

    return res;
  }

  // Future<http.Response> sellerLogin() async {
  //   String sellerLoginUrl = endPoint + '/seller/login';
  //   Seller seller = Seller();
  //   seller.email = _loginEmailControl.text;
  //   seller.pass = _loginPassControl.text;

  //   http.Response res =
  //       await sellerCreateOrLoginRequest(sellerLoginUrl, seller);
  //   String token = res.body; //todo save token in shared preferences

  //   saveToken(token);

  //   if (res.statusCode == no_such_user) {
  //     ShowSnackBar(context, Text('Invalid email'));
  //   } else if (res.statusCode == login_unsuccessfull) {
  //     ShowSnackBar(context, Text('Login unsuccessfull'));
  //   } else if (res.statusCode == 200) {
  //     ShowSnackBar(context, Text('Login successfull'));
  //     Navigator.pop(context, true);
  //   } else {
  //     ShowSnackBar(context, Text('Some Error occured'));
  //   }

  //   return res;
  // }
}
