import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';

Future<String>? convertImageToString(File file) async {
  var bytes = await file.readAsBytes();
  return base64Encode(bytes);
}

Uint8List convertStringtoByteList(String imageString) {
  try {
    return base64Decode(imageString);
  } catch (e) {
    return base64Decode('');
  }
}

Widget convertStringtoImage(String imageString) {
  Uint8List imageBytes = convertStringtoByteList(imageString);
  return imageString.length == 0
      ? Center(child: Text('No image to show'))
      : Image.memory(imageBytes);
}
