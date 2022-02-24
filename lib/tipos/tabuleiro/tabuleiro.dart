import 'dart:io';

import 'package:batalha_naval/tipos/eixo.dart';
import 'package:batalha_naval/tipos/tabuleiro/navio_tabuleiro.dart';

class Tabuleiro {
  late int limiteVertical;
  late int limiteHorizontal;
  late List<NavioTabuleiro> navios;

  Tabuleiro({
    required this.limiteHorizontal,
    required this.limiteVertical,
    List<NavioTabuleiro>? navios,
  }) : this.navios = navios ?? [];

  List<List<String>> gerarTabuleiro() {
    final tabuleiro = this._gerarTabuleiroVaio();

    this.navios.forEach((navio) {
      // Alterar aqui depois
      navio.eixo == Eixo.Vertical ? _desenharNavioVertical(tabuleiro, navio) : _desenharNavioVertical(tabuleiro, navio);
    });

    return tabuleiro;
  }

  List<List<String>> _gerarTabuleiroVaio() {
    return List.generate(this.limiteVertical, (_) => List.generate(this.limiteHorizontal, (index) => '0'));
  }

  void _desenharNavioVertical(List<List<String>> tabuleiro, NavioTabuleiro navio) {
    final coordenadas = List.generate(navio.posicaoFinalY - navio.y, (coordenadaY) => [navio.x, coordenadaY]);

    coordenadas.forEach((coordenada) {
      int coordenadaX = coordenada[0];
      int coordenadaY = coordenada[1];
      tabuleiro[coordenadaX][coordenadaY] = navio.navio.caracterRepresentador;
    });
  }

  bool inserirNavio(NavioTabuleiro navio) {
    final navioEstaDentroDosLimites = navio.eixo == Eixo.Vertical
        ? this._navioEstaDentroDoLimiteVertical(navio)
        : this._navioEstaDentroDoLimiteHorizontal(navio);

    //print(navioEstaDentroDosLimites);
    //print(!this.existeOutroNavioNaPosicao(navio));

    //print("Ja existe: ${this.existeOutroNavioNaPosicao(navio)}\n");

    if (navioEstaDentroDosLimites && !this._existeOutroNavioNaPosicao(navio)) {
      this.navios.add(navio);
      return true;
    }

    return false;
  }

  bool _navioEstaDentroDoLimiteVertical(NavioTabuleiro navioTabuleiro) {
    final tamanhoReal = navioTabuleiro.y + navioTabuleiro.navio.tamanho;
    return tamanhoReal > 0 && tamanhoReal < this.limiteVertical;
  }

  bool _navioEstaDentroDoLimiteHorizontal(NavioTabuleiro navioTabuleiro) {
    final tamanhoReal = navioTabuleiro.x + navioTabuleiro.navio.tamanho;
    return tamanhoReal > 0 && tamanhoReal < this.limiteHorizontal;
  }

  bool _existeOutroNavioNaPosicao(NavioTabuleiro navioAInserir) {
    final naviosComConflito = this.navios.where((navioJaInserido) {
      // print("X Inserir: ${navioAInserir.x}");
      // print("X Ja: ${navioJaInserido.x}");
      // print("X Inserir Final: ${navioJaInserido.posicaoFinalX}");
      // print("X Ja Final: ${navioJaInserido.posicaoFinalX}\n");

      // print("Y Inserir: ${navioAInserir.y}");
      // print("Y Ja: ${navioJaInserido.y}");
      // print("Y Inserir Final: ${navioJaInserido.posicaoFinalY}");
      // print("Y Ja Final: ${navioJaInserido.posicaoFinalY}\n");

      // print((navioAInserir.x >= navioJaInserido.x && navioAInserir.posicaoFinalX <= navioJaInserido.posicaoFinalX));
      // print((navioAInserir.y >= navioJaInserido.y && navioAInserir.posicaoFinalY <= navioJaInserido.posicaoFinalY));

      return (navioAInserir.x >= navioJaInserido.x && navioAInserir.posicaoFinalX <= navioJaInserido.posicaoFinalX) ||
          (navioAInserir.y >= navioJaInserido.y && navioAInserir.posicaoFinalY <= navioJaInserido.posicaoFinalY);
    }).toList();

    return naviosComConflito.length >= 1;
  }

  void imprimirTabuleiro() {
    final tabuleiro = this._gerarTabuleiroVaio();

    stdout.write("\n");

    for (int i = 0; i < limiteVertical; i++) {
      for (int j = 0; j < limiteHorizontal; j++) {
        stdout.write(tabuleiro[i][j] + " ");
      }
      stdout.write("\n");
    }
    stdout.write("\n");
  }
}
