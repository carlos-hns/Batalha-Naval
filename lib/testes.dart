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

main() {
  // final tabuleiroNavio = TabuleiroNavios(limiteHorizontal: 6, limiteVertical: 5);

  // tabuleiroNavio.inserirNavio(NavioTabuleiro(
  //   x: 0,
  //   y: 0,
  //   eixo: Eixo.Horizontal,
  //   navio: Submarino(),
  // ));

  // tabuleiroNavio.inserirNavio(NavioTabuleiro(
  //   x: 5,
  //   y: 4,
  //   eixo: Eixo.Vertical,
  //   navio: Submarino(),
  // ));

  final tabuleiroMaquina = Maquina().geraTabuleiroMaquina(15, 15);

  //MatrizHelper().imprimirMatriz(tabuleiroNavio.gerarTabuleiro());
  MatrizHelper().imprimirMatriz(tabuleiroMaquina.gerarTabuleiro());
  // final List<List<String>> matriz = tabuleiroMaquina.gerarTabuleiro();

  // matriz.toString();

  stdout.write('\n');

  // for (int j = 0; j < matriz.length; j++) {
  //   // for (int i = 0; i < matriz[j].length; i++) {

  //   stdout.write("${matriz[0][j]} ");
  //   stdout.write("${matriz[1][j]} ");
  //   stdout.write("${matriz[2][j]} ");
  //   stdout.write("${matriz[3][j]} ");
  //   stdout.write("${matriz[4][j]} ");
  //   stdout.write("${matriz[5][j]} ");
  //   stdout.write("${matriz[6][j]} ");
  //   stdout.write("${matriz[7][j]} ");
  //   stdout.write("${matriz[8][j]} ");
  //   stdout.write("${matriz[9][j]} ");
  //   stdout.write("${matriz[10][j]} ");
  //   stdout.write("${matriz[11][j]} ");
  //   stdout.write("${matriz[12][j]} ");
  //   stdout.write("${matriz[13][j]} ");
  //   stdout.write("${matriz[14][j]} ");

  //   // }
  //   stdout.write("\n");
  // }

  // stdout.write("\n");

  final tabuleiroTiro = TabuleiroTiros(limiteHorizontal: 15, limiteVertical: 15);

  tabuleiroTiro.inserirTiro(TiroTabuleiro(
    x: 5,
    y: 4,
    tiro: TiroNormal(),
  ));

  tabuleiroTiro.inserirTiro(TiroTabuleiro(
    x: 1,
    y: 1,
    tiro: TiroEspecial(),
  ));

  print(tabuleiroTiro.tiros.length);

  MatrizHelper().imprimirMatriz(tabuleiroTiro.gerarTabuleiro());
}
