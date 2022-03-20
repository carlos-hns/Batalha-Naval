import 'package:batalha_naval/tipos/navios/contra_torpedeiro.dart';
import 'package:batalha_naval/tipos/navios/navio_tanque.dart';
import 'package:batalha_naval/tipos/navios/porta_aviao.dart';
import 'package:batalha_naval/tipos/navios/submarino.dart';
import 'package:batalha_naval/tipos/tabuleiro/navio_tabuleiro.dart';
import 'package:batalha_naval/tipos/tabuleiro/tabuleiro_navios.dart';
import 'package:batalha_naval/tipos/tabuleiro/tabuleiro_tiros.dart';
import 'package:batalha_naval/tipos/tabuleiro/tiro_tabuleiro.dart';
import 'package:batalha_naval/tipos/eixo.dart';
import 'dart:math';

import 'package:batalha_naval/tipos/tabuleiro/tabuleiro_tiros.dart';
import 'package:batalha_naval/tipos/tiros/tiro_especial.dart';
import 'package:batalha_naval/tipos/tiros/tiro_normal.dart';

class Maquina {
  var rng = Random();

  TabuleiroNavios geraTabuleiroMaquina(int limiteHorizontal, int limiteVertical) {
    var tabuleiroNavio = TabuleiroNavios(limiteHorizontal: limiteHorizontal, limiteVertical: limiteVertical);
    gerarPortaAviaoMaquina(tabuleiroNavio);
    gerarNavioTanqueMaquina(tabuleiroNavio);
    gerarNavioTanqueMaquina(tabuleiroNavio);
    gerarContratorpedeirosMaquina(tabuleiroNavio);
    gerarContratorpedeirosMaquina(tabuleiroNavio);
    gerarContratorpedeirosMaquina(tabuleiroNavio);
    gerarSubmarinosMaquina(tabuleiroNavio);
    gerarSubmarinosMaquina(tabuleiroNavio);
    gerarSubmarinosMaquina(tabuleiroNavio);
    gerarSubmarinosMaquina(tabuleiroNavio);

    return tabuleiroNavio;
  }

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

  TabuleiroTiros geraTabuleiroTiroMaquina(int tamanhoH, int tamanhoV) {
    var tabuleiroTiros = TabuleiroTiros(limiteHorizontal: tamanhoH, limiteVertical: tamanhoV);
    //tiroNormalMaquina(tabuleiroTiros);
    //tiroNormalMaquina(tabuleiroTiros);
    tiroEspecialMaquina(tabuleiroTiros);
    tiroEspecialMaquina(tabuleiroTiros);
    return tabuleiroTiros;
  }

  void tiroNormalMaquina(TabuleiroTiros tabuleiroTiros) {
    if (!tabuleiroTiros.inserirTiro(TiroTabuleiro(
        x: rng.nextInt(tabuleiroTiros.limiteHorizontal),
        y: rng.nextInt(tabuleiroTiros.limiteVertical),
        tiro: TiroNormal()))) {
      tiroNormalMaquina(tabuleiroTiros);
    }
  }

  void tiroEspecialMaquina(TabuleiroTiros tabuleiroTiros) {
    if (!tabuleiroTiros.inserirTiro(TiroTabuleiro(
        x: random(1, tabuleiroTiros.limiteHorizontal - 1),
        y: random(1, tabuleiroTiros.limiteVertical - 1),
        tiro: TiroEspecial()))) {
      tiroEspecialMaquina(tabuleiroTiros);
    }
  }

  int random(min, max) {
    return min + Random().nextInt(max - min);
  }
}
