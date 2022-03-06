// import 'package:batalha_naval/widgets/board.dart';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Batalha Naval - Paradigmas',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyPage(),
//     );
//   }
// }

// class MyPage extends StatelessWidget {
//   const MyPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         margin: EdgeInsets.all(8.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Board(
//               columns: 8,
//               rows: 16,
//               xSize: MediaQuery.of(context).size.width / 2 - 25 - 8,
//               ySize: MediaQuery.of(context).size.height - 20,
//             ),
//             SizedBox(
//               width: 50.0,
//             ),
//             Board(
//               columns: 10,
//               rows: 15,
//               xSize: MediaQuery.of(context).size.width / 2 - 25 - 8,
//               ySize: MediaQuery.of(context).size.height - 20,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:batalha_naval/tipos/eixo.dart';
import 'package:batalha_naval/tipos/navios/submarino.dart';
import 'package:batalha_naval/tipos/tabuleiro/navio_tabuleiro.dart';
import 'package:batalha_naval/tipos/tabuleiro/tabuleiro.dart';
import 'package:batalha_naval/utilidades/matriz_helper.dart';

main() {
  final tabuleiro = Tabuleiro(limiteHorizontal: 6, limiteVertical: 5);
  tabuleiro.inserirNavio(NavioTabuleiro(
    x: 0,
    y: 0,
    eixo: Eixo.Horizontal,
    navio: Submarino(),
  ));

  tabuleiro.inserirNavio(NavioTabuleiro(
    x: 1,
    y: 0,
    eixo: Eixo.Horizontal,
    navio: Submarino(),
  ));

  MatrizHelper().imprimirMatriz(tabuleiro.gerarTabuleiro());
}
