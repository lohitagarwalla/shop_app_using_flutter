import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ghs_app/components/constants.dart';
import 'package:ghs_app/components/deleteAlertDialogu.dart';
import 'package:ghs_app/components/network.dart';
import 'package:ghs_app/classes/product.dart';
import 'package:ghs_app/utility-folder/dropDownList.dart';
import 'package:ghs_app/utility-folder/utility.dart';
import 'package:ghs_app/components/viewChosenImage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:loading_overlay/loading_overlay.dart';

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
  final _descriptionControl = TextEditingController();
  final _priceControl = TextEditingController();
  final _categoryControl = TextEditingController();

  final _picker = ImagePicker();
  PickedFile? imagePickedFile;

  String? initialProductName;

  String? dropDownValue;

  bool isLoading = false;

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
    var imagestring = await convertImageToString(File(imagePickedFile!.path));
    setState(() {
      product.imageString = imagestring;
      imageWidget = Image.memory(bytes);
    });
  }

  Widget _previewImages() {
    if (product.getimageString() != '') {
      try {
        return ViewChosenImage(
          child: convertStringtoImage(product.getimageString()),
        );
      } catch (e) {}
    }
    if (imagePickedFile != null) {
      return ViewChosenImage(
        child: imageWidget,
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
      imagePickedFile = await _picker.getImage(source: source);
      updateImageWidget();
    } catch (e) {
      print('Some error occured');
    }
  }

  @override
  void initState() {
    initialProductName = product.getname();
    _nameControl.value = TextEditingValue(text: product.getname());
    _descriptionControl.value =
        TextEditingValue(text: product.getdescription());
    _priceControl.value = TextEditingValue(text: product.getprice().toString());
    dropDownList.contains(product.getCategory())
        ? dropDownValue = product.getCategory()
        : dropDownValue = dropDownList[0];
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

  Future<http.Response> deleteProduct(String itemNo) async {
    http.Response res =
        await deleteRequest(endPoint + '/products/delete/' + itemNo);
    ShowSnackBar(context, Text('Product deleted successfully'));
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: LoadingOverlay(
        isLoading: isLoading,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  _onImageButtonPressed(ImageSource.gallery, context: context);
                },
                child: Text('Choose Image'),
              ),
              showImage(),
              SizedBox(height: 20),
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
              SizedBox(height: 20),
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
              SizedBox(height: 20),
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
              SizedBox(height: 20),
              DropdownButton(
                onTap: () {
                  FocusScope.of(context).unfocus(); // <--- add this
                },
                focusNode: FocusNode(),
                icon: Icon(Icons.keyboard_arrow_down),
                iconSize: 30,
                hint: Text('Select Category'),
                value: dropDownValue,
                items:
                    dropDownList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    child: Text(value),
                    value: value,
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    if (newValue != null) dropDownValue = newValue;
                  });
                },
              ),
              SizedBox(height: 12),
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  Product newproduct = Product(
                    imageString: product.imageString ?? '',
                    name: _nameControl.text,
                    itemNo: 258,
                    description: _descriptionControl.text,
                    price: int.parse(_priceControl.text),
                    category: dropDownValue,
                  );
                  int statusCode;
                  if (title.toLowerCase() == 'edit product') {
                    //edit product case
                    http.Response response = await productCreateOrUpdateRequest(
                        endPoint +
                            '/products/update/' +
                            product.getitemNo().toString(),
                        newproduct,
                        patchRequest);
                    statusCode = response.statusCode;
                  } else {
                    //create product case
                    http.Response response = await productCreateOrUpdateRequest(
                        endPoint + '/products/create', newproduct, postRequest);

                    statusCode = response.statusCode;
                  }
                  if (statusCode == 200) {
                    ShowSnackBar(context, Text('Successfully saved.'));
                  } else {
                    ShowSnackBar(
                        context, Text('Network error. Could not save.'));
                  }
                  setState(() {
                    isLoading = false;
                  });
                  Navigator.pop(context, [newproduct, false]);
                },
                child: Text('Save'),
              ),
              SizedBox(
                height: 12,
              ),
              if (title.toLowerCase() == 'edit product')
                OutlinedButton(
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.red)),
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    switch (await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return DeleteAlertDialog();
                      },
                    )) {
                      case 'Yes':
                        await deleteProduct(product.getitemNo().toString());
                        Navigator.pop(context, [null, true]);
                        break;
                    }
                    setState(() {
                      isLoading = false;
                    });
                  },
                  child: Text('Delete'),
                ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
