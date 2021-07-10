import 'dart:convert';
import 'dart:io';

Future<String>? convertImageToString(File file) async {
  var bytes = await file.readAsBytes();
  return base64Encode(bytes);
}

Future<File>? convertStringToImage(String img) async {
  var bytes = base64Decode(img);

  var file = File("decodedBezkoder.png"); //TODO UPDATE FILE EXTENSION
  return await file.writeAsBytes(bytes);
}
