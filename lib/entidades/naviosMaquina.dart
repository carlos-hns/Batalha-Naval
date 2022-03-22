import 'package:batalha_naval/tipos/navios/contra_torpedeiro.dart';
import 'package:batalha_naval/tipos/navios/navio_tanque.dart';
import 'package:batalha_naval/tipos/navios/porta_aviao.dart';
import 'package:batalha_naval/tipos/navios/submarino.dart';
import 'package:batalha_naval/tipos/tabuleiro/navio_tabuleiro.dart';
import 'package:batalha_naval/tipos/tabuleiro/tabuleiro_navios.dart';
import 'package:batalha_naval/tipos/eixo.dart';
import 'dart:math';

class NaviosMaquina {
  var rng = Random();

  void gerarPortaAviaoMaquina(TabuleiroNavios tabuleiroNavio) {
    if (!tabuleiroNavio.inserirNavio(NavioTabuleiro(
      x: rng.nextInt(tabuleiroNavio.limiteHorizontal),
      y: rng.nextInt(tabuleiroNavio.limiteVertical),
      eixo: gerarEixoAleatorio(),
      navio: PortaAviao(),
    ))) {
      gerarPortaAviaoMaquina(tabuleiroNavio);
    }
  }

  void gerarNavioTanqueMaquina(TabuleiroNavios tabuleiroNavio) {
    if (!tabuleiroNavio.inserirNavio(NavioTabuleiro(
      x: rng.nextInt(tabuleiroNavio.limiteHorizontal),
      y: rng.nextInt(tabuleiroNavio.limiteVertical),
      eixo: gerarEixoAleatorio(),
      navio: NavioTanque(),
    ))) {
      gerarNavioTanqueMaquina(tabuleiroNavio);
    }
  }

  void gerarContratorpedeirosMaquina(TabuleiroNavios tabuleiroNavio) {
    if (!tabuleiroNavio.inserirNavio(NavioTabuleiro(
      x: rng.nextInt(tabuleiroNavio.limiteHorizontal),
      y: rng.nextInt(tabuleiroNavio.limiteVertical),
      eixo: gerarEixoAleatorio(),
      navio: ContraTorpedeiro(),
    ))) {
      gerarContratorpedeirosMaquina(tabuleiroNavio);
    }
  }

  void gerarSubmarinosMaquina(TabuleiroNavios tabuleiroNavio) {
    if (!tabuleiroNavio.inserirNavio(NavioTabuleiro(
      x: rng.nextInt(tabuleiroNavio.limiteHorizontal),
      y: rng.nextInt(tabuleiroNavio.limiteVertical),
      eixo: gerarEixoAleatorio(),
      navio: Submarino(),
    ))) {
      gerarSubmarinosMaquina(tabuleiroNavio);
    }
  }

  Eixo gerarEixoAleatorio() {
    var aleatorio = rng.nextInt(50);
    if (aleatorio % 2 == 0) {
      return Eixo.Vertical;
    } else {
      return Eixo.Horizontal;
    }
  }
}
