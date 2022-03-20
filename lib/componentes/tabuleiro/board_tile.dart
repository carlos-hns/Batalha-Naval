import 'package:flutter/material.dart';

class BoardTile extends StatefulWidget {
  final Color? color;
  final Function() onTap;

  BoardTile({
    required this.onTap,
    this.color,
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
              color: this._isHover ? Colors.blue : (this.widget.color ?? Colors.black),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
