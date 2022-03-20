import 'package:batalha_naval/paginas/insercao_navios_page.dart';
import 'package:batalha_naval/paginas/jogo_page.dart';
import 'package:batalha_naval/paginas/menu_page.dart';
import 'package:batalha_naval/paginas/pagina_testes.dart';
import 'package:batalha_naval/tipos/tabuleiro/tabuleiro_navios.dart';
import 'package:flutter/material.dart';

import 'injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Batalha Naval",
      debugShowCheckedModeBanner: false,
      //home: MenuPage(),
      home: JogoPage(
        tabuleiroNavios: TabuleiroNavios(limiteHorizontal: 15, limiteVertical: 15),
      ),
      //home: PaginaTestes(),
    );
  }
}
