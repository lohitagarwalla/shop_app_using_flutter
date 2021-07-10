import 'package:flutter/material.dart';

class ViewChosenImage extends StatelessWidget {
  ViewChosenImage({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blueAccent,
          width: 1.7,
        ),
        color: Color.fromARGB(10, 10, 10, 10),
        borderRadius: BorderRadius.circular(10),
      ),
      height: 300,
      margin: const EdgeInsets.all(15.0),
      padding: EdgeInsets.all(10),
      width: double.infinity,
      child: Center(child: child),
    );
  }
}
