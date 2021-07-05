import 'package:flutter/material.dart';

class ItemInfoText extends StatelessWidget {
  const ItemInfoText({
    Key? key,
    required this.value,
    this.property = '',
  }) : super(key: key);

  final String value;
  final String property;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: <TextSpan>[
          TextSpan(
              text: property + ': ',
              style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: value, style: TextStyle()),
        ],
      ),
      maxLines: 5,
      overflow: TextOverflow.ellipsis,
    );
  }
}
