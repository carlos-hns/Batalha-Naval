import 'package:flutter/material.dart';

class BatalhaBoard extends StatefulWidget {
  late int x;
  late int y;

  BatalhaBoard({
    required this.x,
    required this.y,
    Key? key,
  }) : super(key: key);

  @override
  State<BatalhaBoard> createState() => _BatalhaBoardState();
}

class _BatalhaBoardState extends State<BatalhaBoard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(widget.x, (currentX) => this._createRow(currentX)),
    );
  }

  Row _createRow(int currentX) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.y,
        (currentY) => BoardTile(
          onTap: () {
            print("X: ${currentX} - Y: ${currentY}");
          },
        ),
      ),
    );
  }
}

class BoardTile extends StatefulWidget {
  late final Function() onTap;

  BoardTile({
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  State<BoardTile> createState() => _BoardTileState();
}

class _BoardTileState extends State<BoardTile> {
  bool _isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          this._isHover = true;
        });
      },
      onExit: (_) {
        setState(() {
          this._isHover = false;
        });
      },
      child: GestureDetector(
        onTap: this.widget.onTap,
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: AnimatedContainer(
            duration: Duration(seconds: 1),
            height: 25.0,
            width: 25.0,
            decoration: BoxDecoration(
              color: this._isHover ? Colors.blue : Colors.black,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
