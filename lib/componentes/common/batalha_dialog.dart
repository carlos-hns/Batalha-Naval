import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showBatalhaDialog(BuildContext context, String title, String description, Function() onTap) {
  return showDialog(
    context: context,
    builder: (context) {
      return BatalhaDialog(
        title: title,
        description: description,
        onTap: onTap,
      );
    },
  );
}

class BatalhaDialog extends StatelessWidget {
  String title;
  String description;
  Function() onTap;

  BatalhaDialog({
    required this.title,
    required this.description,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(
        this.title,
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(this.description),
      actions: [
        CupertinoDialogAction(
          child: Text("Ok"),
          onPressed: this.onTap,
        ),
      ],
    );
  }
}
