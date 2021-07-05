import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  const BottomButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(),
        ),
        GestureDetector(
          onTap: () {
            print('Show more button pressed');
          },
          child: Container(
            width: 150,
            padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(30)),
            child: Center(
              child: Text(
                'Show More',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(),
        ),
      ],
    );
  }
}
