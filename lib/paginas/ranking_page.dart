import 'package:batalha_naval/app_colors.dart';
import 'package:batalha_naval/componentes/common/batalha_botao.dart';
import 'package:batalha_naval/paginas/menu_page.dart';
import 'package:batalha_naval/tipos/ranking.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class RankingPage extends StatefulWidget {
  const RankingPage({Key? key}) : super(key: key);

  @override
  State<RankingPage> createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  late final Box rankingBox;
  late List<Ranking> elements10x10;
  late List<Ranking> elements15x15;

  @override
  void initState() {
    super.initState();

    this.rankingBox = Hive.box('ranking');
    elements10x10 = this._get10x10Ranking();
    elements15x15 = this._get15x15Ranking();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF222623),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BatalhaBotao(
                  label: "Voltar para o menu",
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return MenuPage();
                        },
                      ),
                    );
                  }),
              SizedBox(
                width: 50.0,
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      "Ranking 10x10",
                      style: TextStyle(
                        color: TextColor,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      padding: EdgeInsets.all(15.0),
                      height: constraints.constrainHeight() * 0.9,
                      width: 500.0,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        children: elements10x10
                            .map(
                              (element) => Text(
                                "${element.nome} - Tiros Normais: ${element.numeroDeTirosNormais} - Tiros Especiais: ${element.numeroDeTirosEspeciais}",
                                style: TextStyle(
                                  color: TextColor,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 15.0,
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      "Ranking 15x15",
                      style: TextStyle(
                        color: TextColor,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      padding: EdgeInsets.all(15.0),
                      height: constraints.constrainHeight() * 0.9,
                      width: 500.0,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        children: elements15x15
                            .map(
                              (element) => Text(
                                "${element.nome} - Tiros Normais: ${element.numeroDeTirosNormais} - Tiros Especiais: ${element.numeroDeTirosEspeciais}",
                                style: TextStyle(
                                  color: TextColor,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  List<Ranking> _get10x10Ranking() {
    final elements = this.rankingBox.values.cast<Ranking>();
    final List<Ranking> filtered = elements.where((element) => element.tamanhoTabuleiro == "10x10").toList();

    filtered.sort((a, b) {
      return a.numeroDeTirosEspeciais.compareTo(b.numeroDeTirosEspeciais) +
          a.numeroDeTirosNormais.compareTo(b.numeroDeTirosNormais);
    });

    return filtered;
  }

  List<Ranking> _get15x15Ranking() {
    final elements = this.rankingBox.values.cast<Ranking>();
    final List<Ranking> filtered = elements.where((element) => element.tamanhoTabuleiro == "15x15").toList();

    filtered.sort((a, b) {
      return a.numeroDeTirosEspeciais.compareTo(b.numeroDeTirosEspeciais) +
          a.numeroDeTirosNormais.compareTo(b.numeroDeTirosNormais);
    });

    return filtered;
  }
}
