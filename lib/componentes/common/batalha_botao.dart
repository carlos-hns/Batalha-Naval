import 'package:flutter/material.dart';

import '../../app_colors.dart';

class BatalhaBotao extends StatelessWidget {
  String label;
  Function() onTap;
  Color? labelColor;
  Color? backGroundColor;

  BatalhaBotao({
    required this.label,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: this.onTap,
      style: ElevatedButton.styleFrom(
        primary: this.backGroundColor ?? PrimaryColor,
        fixedSize: Size(250.0, 50.0),
      ),
      child: Text(
        this.label,
        style: TextStyle(
          color: this.labelColor ?? TextColor,
        ),
      ),
    );
  }
}
