import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ghs_app/components/constants.dart';
import 'package:ghs_app/components/network.dart';
import 'package:ghs_app/components/product.dart';
import 'package:ghs_app/components/utility.dart';
import 'package:ghs_app/components/viewChosenImage.dart';
import 'package:image_picker/image_picker.dart';

class AddProductPage extends StatefulWidget {
  final Product product;
  final String title;

  AddProductPage({Key? key, required this.product, required this.title})
      : super(key: key);

  @override
  _AddProductPageState createState() =>
      _AddProductPageState(product: this.product, title: this.title);
}

class _AddProductPageState extends State<AddProductPage> {
  _AddProductPageState({required this.product, required this.title});

  Product product;
  String title;

  final _nameControl = TextEditingController();
  String? nameInit;

  final _descriptionControl = TextEditingController();
  String? descriptionInit;

  final _priceControl = TextEditingController();
  String? priceInit;

  final _categoryControl = TextEditingController();
  String? categoryInit;

  final _picker = ImagePicker();
  PickedFile? imagePickedFile;
  String? imageString;

  Future<void> retrieveLostData() async {
    final LostData response = await _picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        imagePickedFile = response.file;
      });
    } else {}
  }

  Widget imageWidget = Container();

  updateImageWidget() async {
    var bytes = await File(imagePickedFile!.path).readAsBytes();
    String imagestring = base64Encode(bytes);
    var decodedBytes = base64Decode(imagestring);
    setState(() {
      imageWidget = Image.memory(decodedBytes);
    });
  }

  Widget _previewImages() {
    if (imagePickedFile != null) {
      return ViewChosenImage(
        child:
            imageWidget, // Image.memory(await File(imagePickedFile!.path).readAsBytes()),
        // child: Image.file(
        //   File(imagePickedFile!.path),
        // ),
      );
    } else {
      return ViewChosenImage(
        child: Text(
          'You have not yet picked an image.',
          textAlign: TextAlign.center,
        ),
      );
    }
  }

  Widget showImage() {
    return FutureBuilder<void>(
      future: retrieveLostData(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const Text(
              'You have not yet picked an image.',
              textAlign: TextAlign.center,
            );
          case ConnectionState.done:
            return _previewImages();
          default:
            if (snapshot.hasError) {
              return ViewChosenImage(
                child: Text(
                  'Pick image error: ${snapshot.error}}',
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              return ViewChosenImage(
                child: Text(
                  'You have not yet picked an image.',
                  textAlign: TextAlign.center,
                ),
              );
            }
        }
      },
    );
  }

  void _onImageButtonPressed(ImageSource source,
      {BuildContext? context}) async {
    try {
      final pickedFile = await _picker.getImage(source: source);
      setState(() {
        imagePickedFile = pickedFile;
      });
      imageString = await convertImageToString(File(pickedFile!.path));
      updateImageWidget();
    } catch (e) {
      print('Some error occured');
      setState(() {});
    }
  }

  @override
  void initState() {
    _nameControl.value = TextEditingValue(text: product.getname());
    _descriptionControl.value =
        TextEditingValue(text: product.getdescription());
    _priceControl.value = TextEditingValue(text: product.getprice().toString());
    _categoryControl.value = TextEditingValue(text: product.getCategory());
    super.initState();
  }

  @override
  void dispose() {
    _nameControl.dispose();
    _descriptionControl.dispose();
    _priceControl.dispose();
    _categoryControl.dispose();
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                _onImageButtonPressed(ImageSource.gallery, context: context);
              },
              child: Text('Choose Image'),
            ),
            showImage(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: _nameControl,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                    hintText: 'Enter name of the product'),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                controller: _descriptionControl,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Description',
                    hintText: 'Enter Description of the product'),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: _priceControl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Price',
                    hintText: 'Enter Price of the product'),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: _categoryControl,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Category',
                    hintText: 'Enter Category of the product'),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                Product newproduct = Product(
                  imageString: imageString ?? 'image string',
                  name: _nameControl.text,
                  itemNo: 251,
                  description: _descriptionControl.text,
                  price: int.parse(_priceControl.text),
                  category: _categoryControl.text,
                );
                createProduct(endPoint + '/products/create', newproduct);
              },
              child: Text('Save'),
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
