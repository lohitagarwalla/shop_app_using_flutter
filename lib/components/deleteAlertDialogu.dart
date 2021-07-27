import 'package:flutter/material.dart';

class DeleteAlertDialog extends StatelessWidget {
  const DeleteAlertDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Delete this product'),
      content: Text('Are you sure to delete?'),
      actions: [
        SimpleDialogOption(
          onPressed: () {
            Navigator.pop(context, 'Yes');
          },
          child: Text('Yes'),
        ),
        SimpleDialogOption(
          onPressed: () {
            Navigator.pop(context, 'No');
          },
          child: Text('No'),
        ),
      ],
    );
  }
}
