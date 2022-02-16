import 'package:flutter/material.dart';
import 'package:ghs_app/classes/user.dart';
import 'package:ghs_app/components/constants.dart';
import 'package:ghs_app/components/network.dart';
import 'package:ghs_app/utility-folder/utility.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:http/http.dart' as http;

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isLoading = false;

  final _signupCompanyNameControl = TextEditingController();
  final _signupNameControl = TextEditingController();
  final _signupEmailControl = TextEditingController();
  final _signupPhoneControl = TextEditingController();
  final _signupPassControl = TextEditingController();
  final _signupConfirmPassControl = TextEditingController();

  @override
  void dispose() {
    _signupCompanyNameControl.dispose();
    _signupNameControl.dispose();
    _signupEmailControl.dispose();
    _signupPhoneControl.dispose();
    _signupPassControl.dispose();
    _signupConfirmPassControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: LoadingOverlay(
        isLoading: isLoading,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              if (widget.title.toLowerCase() == 'seller sign up')
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    controller: _signupCompanyNameControl,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Company name',
                        hintText: 'Enter your name of your company'),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextField(
                  controller: _signupNameControl,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                      hintText: 'Enter your Name'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextField(
                  controller: _signupEmailControl,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      hintText: 'Enter valid email id as abc@gmail.com'),
                ),
              ),
              if (widget.title.toLowerCase() == 'seller sign up')
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  child: TextField(
                    keyboardType: TextInputType.phone,
                    controller: _signupPhoneControl,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Phone',
                        hintText: 'Enter your phone number'),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextField(
                  controller: _signupPassControl,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Enter secure password'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextField(
                  controller: _signupConfirmPassControl,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Confirm Password',
                      hintText: 'Confirm Password'),
                ),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () async {
                  if (_signupConfirmPassControl.text !=
                      _signupPassControl.text) {
                    ShowSnackBar(context, Text('Passwords does not match'));
                    return;
                  }

                  setState(() {
                    isLoading = true;
                  });

                  if (widget.title.toLowerCase() == 'seller sign up') {
                    // await sellerSignup();
                  } else {
                    await userSignup();
                  }

                  setState(() {
                    isLoading = false;
                  });
                },
                child: Text('Sign Up'),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Future<http.Response> userSignup() async {
    String signupUrl = endPoint + '/users/create';

    User user = User();
    User.name = _signupNameControl.text;
    User.email = _signupEmailControl.text;
    User.pass = _signupPassControl.text;
    http.Response res = await userCreateOrLoginRequest(signupUrl);
    String token = res.body; //todo save token in shared preferences

    // saveToken(token);

    if (res.statusCode == user_already_exist) {
      ShowSnackBar(context, Text('Accout with this email already exists!'));
    } else if (res.statusCode == 200) {
      ShowSnackBar(context, Text('Account created successfull'));
      Navigator.pop(context, true);
    } else {
      ShowSnackBar(context, Text('Some Error occured'));
    }
    return res;
  }

  // Future<http.Response> sellerSignup() async {
  //   String signupUrl = endPoint + '/seller/create';

  //   Seller seller = Seller();
  //   seller.companyName = _signupCompanyNameControl.text;
  //   seller.name = _signupNameControl.text;
  //   seller.email = _signupEmailControl.text;
  //   seller.phone = _signupPhoneControl.text as int;
  //   seller.pass = _signupPassControl.text;
  //   http.Response res = await sellerCreateOrLoginRequest(signupUrl, seller);
  //   String token = res.body; //todo save token in shared preferences

  //   // saveToken(token);

  //   if (res.statusCode == user_already_exist) {
  //     ShowSnackBar(
  //         context, Text('Seller account with this email already exists!'));
  //   } else if (res.statusCode == 200) {
  //     ShowSnackBar(context, Text('Seller account created successfully'));
  //   } else {
  //     ShowSnackBar(context, Text('Some Error occured'));
  //   }

  //   return res;
  // }
}
