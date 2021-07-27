import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ghs_app/classes/user.dart';
import 'package:ghs_app/components/constants.dart';
import 'package:ghs_app/components/network.dart';
import 'package:ghs_app/utility-folder/shared-preferences-storage.dart';
import 'package:ghs_app/utility-folder/utility.dart';
import 'package:http/http.dart' as http;

const String loginUrl = endPoint + '/users/login';

const user_already_exist = 900;
const no_such_user = 901;
const login_unsuccessfull = 902;

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

  final _signupNameControl = TextEditingController();
  final _signupEmailControl = TextEditingController();
  final _signupPassControl = TextEditingController();
  final _signupConfirmPassControl = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _loginEmailControl.dispose();
    _loginPassControl.dispose();

    _signupNameControl.dispose();
    _signupEmailControl.dispose();
    _signupPassControl.dispose();
    _signupConfirmPassControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
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
                    User user = User();
                    user.email = _loginEmailControl.text;
                    user.pass = _loginPassControl.text;

                    http.Response res =
                        await userCreateOrLoginRequest(loginUrl, user);
                    String token =
                        res.body; //todo save token in shared preferences

                    saveToken(token);

                    if (res.statusCode == no_such_user) {
                      ShowSnackBar(context, Text('Invalid email'));
                      return;
                    } else if (res.statusCode == login_unsuccessfull) {
                      ShowSnackBar(context, Text('Login unsuccessfull'));
                      return;
                    } else if (res.statusCode == 200) {
                      ShowSnackBar(context, Text('Login successfull'));
                      Navigator.pop(context, true);
                    } else {
                      ShowSnackBar(context, Text('Some Error occured'));
                      return;
                    }
                  },
                  child: Text('Login'),
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: Text('Forgot Password'),
                ),
              ],
            ),
            // SizedBox(height: 70),
            Divider(
              height: 100,
              thickness: 1,
            ),
            Text('Dont have an account?'),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
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
                if (_signupConfirmPassControl.text != _signupPassControl.text) {
                  ShowSnackBar(context, Text('Passwords does not match'));
                  return;
                }

                String signupUrl = endPoint + '/users/create';

                User user = User();
                user.name = _signupNameControl.text;
                user.email = _signupEmailControl.text;
                user.pass = _signupPassControl.text;
                http.Response res =
                    await userCreateOrLoginRequest(signupUrl, user);
                String token = res.body; //todo save token in shared preferences
                if (res.statusCode == user_already_exist) {
                  ShowSnackBar(
                      context, Text('Accout with this email already exists!'));
                  return;
                } else if (res.statusCode == 200) {
                  ShowSnackBar(context, Text('Account created successfull'));
                } else {
                  ShowSnackBar(context, Text('Some Error occured'));
                  return;
                }
              },
              child: Text('Sign Up'),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
