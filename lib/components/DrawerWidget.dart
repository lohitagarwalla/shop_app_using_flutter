import 'package:flutter/material.dart';
import 'package:ghs_app/classes/user.dart';
import 'package:ghs_app/screens/login_page.dart';
import 'package:ghs_app/screens/profile_page.dart';

class DrawerWidget extends StatelessWidget {
  final String title;
  final BuildContext context;

  DrawerWidget({Key? key, required this.context, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: createDynamicListView(),
      ),
    );
  }

  List<Widget> createDynamicListView() {
    List<Widget> children = [];
    children
      ..addAll(headers())
      ..addAll(options())
      ..addAll([Divider()])
      ..addAll(settings());
    return children;
  }

  List<Widget> headers() {
    List<Widget> children = [];
    children.add(Container(
      padding: EdgeInsets.all(16),
      height: 100,
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(fontSize: 25, color: Colors.white),
      ),
      decoration: BoxDecoration(color: Colors.blue),
    ));
    return children;
  }

  List<Widget> options() {
    List<Widget> children = [];
    children.add(ListTile(
      title: Text('Category 1'),
      onTap: () {
        //TODO Add functionality for selecting category
      },
    ));

    children.add(ListTile(
      title: Text('Category 2'),
      onTap: () {
        //TODO Add functionality for selecting category
      },
    ));
    return children;
  }

  List<Widget> settings() {
    List<Widget> children = [];
    children.add(
      ListTile(
          onTap: () async {
            if (User.email != '') {
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ProfileScreen(title: 'User Account')));
            } else {
              var result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          LoginScreen(title: 'User Login', isLogged: false)));
              print('result ' + result.toString());
              if (result == true) {
                // updateIsSellerLogged(true);
                Navigator.pop(context);
              }
            }
          },
          title: Text('User Account')
          // async {
          //   String token = await getToken();
          //   if (token == no_token_found) {
          //     var result = await Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //             builder: (context) =>
          //                 LoginScreen(title: 'Seller Login', isLogged: false)));
          //     print('result ' + result.toString());
          //     if (result == true) {
          //       updateIsSellerLogged(true);
          //       Navigator.pop(context);
          //     }
          //   } else {
          //     var value = await Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //             builder: (context) =>
          //                 ProfileScreen(title: 'Seller Profile')));
          //     if (value == false) {
          //       //seller logged out
          //       updateIsSellerLogged(false);
          //       Navigator.pop(context);
          //     }
          //   }
          // },
          ),
    );
    children.add(ListTile(title: Text('Settings')));
    return children;
  }
}
