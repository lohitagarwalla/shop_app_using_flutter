import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ghs_app/utility-folder/shared-preferences-storage.dart';

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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CircleAvatar(
            child: Text('Photo'),
            radius: 40,
          ),
          SizedBox(height: 15),
          Center(child: Text('Name')),
          SizedBox(height: 15),
          Center(child: Text('Email')),
          SizedBox(height: 15),
          Center(
              child: ElevatedButton(
                  onPressed: () async {
                    await removeToken();
                    Navigator.pop(context, false);
                  },
                  child: Text('Logout'))),
        ],
      ),
    );
  }
}
