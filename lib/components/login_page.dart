import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Padding(
          //   padding: const EdgeInsets.only(top: 60.0),
          //   child: Center(
          //     child: Container(
          //         width: 200,
          //         height: 150,
          //         /*decoration: BoxDecoration(
          //               color: Colors.red,
          //               borderRadius: BorderRadius.circular(50.0)),*/
          //         child: Image.asset('asset/images/flutter-logo.png')),
          //   ),
          // ),
          Padding(
            //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  hintText: 'Enter valid email id as abc@gmail.com'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 15, bottom: 0),
            //padding: EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  hintText: 'Enter secure password'),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(
                EdgeInsets.fromLTRB(40, 10, 40, 10),
              ),
            ),
            onPressed: () {
              // Navigator.push(
              //     context, MaterialPageRoute(builder: (_) => HomePage()));
            },
            child: Text(
              'Login',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {
              //TODO FORGOT PASSWORD SCREEN GOES HERE
            },
            child: Text(
              'Forgot Password',
              style: TextStyle(fontSize: 15),
            ),
          ),
          SizedBox(
            height: 130,
          ),
          Text('New User? Create Account')
        ],
      ),
    );
  }
}
