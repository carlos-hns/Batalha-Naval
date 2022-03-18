import 'package:flutter/material.dart';

class BatalhaBoard extends StatelessWidget {
  late int x;
  late int y;

  BatalhaBoard({
    required this.x,
    required this.y,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(x, (index) => this._createRow()),
    );
  }

  Row _createRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(y, (index) => this._createElement()),
    );
  }

  Widget _createElement() {
    return GestureDetector(
      onTap: () {}, // TODO: MAKE IT AFTER
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: Container(
          height: 25.0,
          width: 25.0,
          decoration: BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
