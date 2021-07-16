import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

Future<String>? convertImageToString(File file) async {
  var bytes = await file.readAsBytes();
  return base64Encode(bytes);
}

Uint8List convertStringtoByteList(String imageString) {
  return base64Decode(imageString);
}
