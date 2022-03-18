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
      children: List.generate(x, (currentX) => this._createRow(currentX)),
    );
  }

  Row _createRow(int currentX) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(y, (currentY) => this._createElement(currentX, currentY)),
    );
  }

  Widget _createElement(int currentX, int currentY) {
    return GestureDetector(
      onTap: () {
        print("X: ${currentY}, Y: ${currentX}");
      },
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
