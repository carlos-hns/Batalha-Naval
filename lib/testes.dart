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
import 'package:batalha_naval/tipos/tabuleiro/tabuleiro_navios.dart';
import 'package:batalha_naval/tipos/tabuleiro/tabuleiro_tiros.dart';
import 'package:batalha_naval/tipos/tabuleiro/tiro_tabuleiro.dart';
import 'package:batalha_naval/tipos/tiros/tiro_especial.dart';
import 'package:batalha_naval/tipos/tiros/tiro_normal.dart';
import 'package:batalha_naval/utilidades/matriz_helper.dart';
import 'dart:io';
import 'entidades/maquina.dart';
import 'package:flutter/widgets.dart';

main() {
  var tabuleiroNavio = TabuleiroNavios(limiteHorizontal: 15, limiteVertical: 15);
  MatrizHelper().imprimirMatriz(tabuleiroNavio.gerarTabuleiro());

//   final tabuleiroMaquina = Maquina().geraTabuleiroMaquina(15, 15);
// //  MatrizHelper().imprimirMatriz(tabuleiroMaquina.gerarTabuleiro());

//   final tabuleiroTiro = Maquina().geraTabuleiroTiroMaquina(15, 15);

//   MatrizHelper().imprimirMatriz(tabuleiroTiro.gerarTabuleiro());

//   List<List<String>> tabuleiroMaquina2 = tabuleiroMaquina.gerarTabuleiro();
//   //tabuleiroMaquina2 = tabuleiroTiro.gerarTabuleiro();

//   MatrizHelper().imprimirMatriz(tabuleiroMaquina2);
}
