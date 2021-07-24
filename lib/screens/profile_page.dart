import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ghs_app/classes/user.dart';
import 'package:ghs_app/components/constants.dart';
import 'package:ghs_app/components/network.dart';
import 'package:ghs_app/utility-folder/shared-preferences-storage.dart';
import 'package:ghs_app/utility-folder/utility.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key, required this.title, required this.isLogged})
      : super(key: key);

  final String title;
  final bool isLogged;

  @override
  _ProfileScreenState createState() =>
      _ProfileScreenState(title: title, isLogged: isLogged);
}

class _ProfileScreenState extends State<ProfileScreen> {
  _ProfileScreenState({required this.title, required this.isLogged});

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
          children: [
            SizedBox(height: 20),
            CircleAvatar(),
            RichText(
                text: TextSpan(children: [TextSpan(text: 'Lohit Agarwalla')]))
          ],
        ),
      ),
    );
  }
}
