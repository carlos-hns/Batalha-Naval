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
  bool _isHover = false;

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
      children: List.generate(widget.y, (currentY) => this._createElement(currentX, currentY)),
    );
  }

  Widget _createElement(int currentX, int currentY) {
    return MouseRegion(
      onEnter: (_) {
        print("Teste");
        setState(() {
          this._isHover = true;
        });
      },
      onExit: (_) {
        setState(() {
          this._isHover = false;
        });
      },
      // onHover: (event) {
      //   print(event);
      //   setState(() {
      //     this._isHover = true;
      //   });
      // },
      child: GestureDetector(
        onTap: () {
          print("X: ${currentY}, Y: ${currentX}");
        },
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

// Deve estar mudando tudo pq o widget está sendo completamente rebuildado quando
// ativa o mouse region, logo todo o board é reconstruido
// como a gente tem uma função e não um stateless widdget

// Transformar o container em um widget statefull
// Retornar o board para stateless

// class PointElement extends StatelessWidget {
//   const PointElement({
//     required onEnter,
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MouseRegion(
//       onEnter: (_) {
//         print("Teste");
//         setState(() {
//           this._isHover = true;
//         });
//       },
//       onExit: (_) {
//         setState(() {
//           this._isHover = false;
//         });
//       },
//       // onHover: (event) {
//       //   print(event);
//       //   setState(() {
//       //     this._isHover = true;
//       //   });
//       // },
//       child: GestureDetector(
//         onTap: () {
//           print("X: ${currentY}, Y: ${currentX}");
//         },
//         child: Padding(
//           padding: EdgeInsets.all(5.0),
//           child: AnimatedContainer(
//             duration: Duration(seconds: 1),
//             height: 25.0,
//             width: 25.0,
//             decoration: BoxDecoration(
//               color: this._isHover ? Colors.blue : Colors.black,
//               shape: BoxShape.circle,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
