import 'dart:math';
import 'package:flutter/material.dart';

class Board extends StatefulWidget {
  final int columns;
  final int rows;
  final double xSize;
  final double ySize;

  const Board({
    required this.columns,
    required this.rows,
    required this.xSize,
    required this.ySize,
    Key? key,
  }) : super(key: key);

  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.xSize,
      height: widget.ySize,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(
          color: Colors.black,
          width: 5.0,
        ),
      ),
      child: GridView.builder(
        itemCount: widget.rows * widget.columns,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: widget.columns,
          mainAxisExtent: widget.ySize / widget.rows,
          //crossAxisSpacing: 0.5,
          //mainAxisSpacing: 0.5,
        ),
        itemBuilder: (context, index) {
          return Container(
            color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
            // decoration: BoxDecoration(
            //   border: Border.all(
            //     color: Colors.black,
            //     width: 1.0,
            //   ),
            //   color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
            // ),
            child: Center(child: Text(index.toString())),
          );
        },
      ),
    );
  }
}
