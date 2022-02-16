import 'package:flutter/material.dart';
import 'package:ghs_app/utility-folder/utility.dart';
import 'package:loading_overlay/loading_overlay.dart';

const vertical_pading = 10.0;
const horizontal_pading = 15.0;

class AddAddress extends StatefulWidget {
  AddAddress({Key? key, required this.title}) : super(key: key);

  String title;

  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                LoadingOverlay(
                  isLoading: isLoading,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 20),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: vertical_pading),
                          child: TextField(
                            // controller: _loginEmailControl,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Address',
                                hintText:
                                    'Enter Building and street name details'),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: vertical_pading),
                          child: TextField(
                            // controller: _loginEmailControl,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Village',
                                hintText: 'Enter Village name'),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: vertical_pading),
                          child: TextField(
                            // controller: _loginEmailControl,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'City',
                                hintText: 'Enter City'),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: vertical_pading),
                          child: TextField(
                            // controller: _loginEmailControl,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Pincode',
                                hintText: 'Enter 6 digit pincode'),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: vertical_pading),
                          child: TextField(
                            // controller: _loginEmailControl,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'State',
                                hintText: 'Enter State'),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: vertical_pading),
                          child: TextField(
                            // controller: _loginEmailControl,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Phone',
                                hintText: 'Enter 10 digit mobile number'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      persistentFooterButtons: [
        ElevatedButton(
          onPressed: () async {
            setState(() {
              isLoading = true;
            });
            //TODO Implement the logic for save address and continue;
            Navigator.pop(context);
            Navigator.pop(context);
            setState(() {
              isLoading = false;
            });
            ShowSnackBar(
                context,
                Text(
                    'Thanks for your interest ❤.   We will get back to you ✔'));
          },
          child: Text('Save and Continue'),
        )
      ],
    );
  }
}
