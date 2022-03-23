import 'package:batalha_naval/paginas/menu_page.dart';
import 'package:batalha_naval/tipos/ranking.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();

  // Banco de dados
  await Hive.initFlutter();
  Hive.registerAdapter(RankingAdapter());
  await Hive.openBox('ranking');

  // Descomente para limpar o banco de dados
  //Hive.box('ranking').clear();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Batalha Naval",
      debugShowCheckedModeBanner: false,
      home: MenuPage(),
    );
  }
}
