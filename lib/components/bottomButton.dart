import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  const BottomButton({
    required this.callShowMore,
    Key? key,
  }) : super(key: key);

  final Function callShowMore;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: Text('Show More'),
        onPressed: () {
          callShowMore();
        },
      ),
    );
  }
}
