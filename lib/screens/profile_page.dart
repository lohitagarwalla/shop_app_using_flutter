import 'package:flutter/material.dart';
import 'package:ghs_app/classes/user.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ProfileScreenState createState() => _ProfileScreenState(title: title);
}

class _ProfileScreenState extends State<ProfileScreen> {
  _ProfileScreenState({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Text(
              User.email,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 15),
          Center(
              child: ElevatedButton(
                  onPressed: () async {
                    User.email = '';
                    User.name = '';
                    User.pass = '';
                    Navigator.pop(context, false);
                  },
                  child: Text('Logout'))),
        ],
      ),
    );
  }
}
