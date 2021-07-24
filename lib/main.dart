import 'package:flutter/material.dart';
import 'package:ghs_app/screens/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'my_app',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
