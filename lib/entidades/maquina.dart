import 'package:batalha_naval/tipos/navios/contra_torpedeiro.dart';
import 'package:batalha_naval/tipos/navios/navio_tanque.dart';
import 'package:batalha_naval/tipos/navios/porta_aviao.dart';
import 'package:batalha_naval/tipos/navios/submarino.dart';
import 'package:batalha_naval/tipos/tabuleiro/navio_tabuleiro.dart';
import 'package:batalha_naval/tipos/tabuleiro/tabuleiro_navios.dart';
import 'package:batalha_naval/tipos/eixo.dart';
import 'dart:math';

class Maquina {
  //criar função para atirar no jogador{tiros aleatorios até identificar um acerto e a partir dele seguir para destruir o navio completamente}

  //criar função para gerar automaticamente e aleatoriamente os navios da maquina
  /*
  recebe tamanho do tabuleiro
  retornar coordenadas, eixo e List<navios>
  1 porta aviões
  2 navios-tanque
  3 contratorpedeiros
  4 submarinos
  
   */

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
}
