import 'package:batalha_naval/tipos/coordenada.dart';
import 'package:batalha_naval/tipos/tabuleiro/tabuleiro_navios.dart';
import 'package:batalha_naval/utilidades/matriz_helper.dart';

import 'entidades/maquina.dart';

class Batalha {
  final tabuleiroMaquina = Maquina().geraTabuleiroMaquina(15, 15);
  final tabuleiroTiro = Maquina().geraTabuleiroTiroMaquina(15, 15);
  void main(List<String> args) {
    List<List<String>> tabuleiroMaquina2 = tabuleiroMaquina.gerarTabuleiro();
    tabuleiroMaquina2 = tabuleiroTiro.gerarTabuleiro();

    MatrizHelper().imprimirMatriz(tabuleiroMaquina2);

    // = tabuleiroTiro.gerarTabuleiro();
  }

  void atirarNaMaquina(Coordenada coordenadas) {}
}
