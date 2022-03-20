import 'package:batalha_naval/tipos/coordenada.dart';
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

import 'package:batalha_naval/tipos/tiros/tiro_especial.dart';
import 'package:batalha_naval/tipos/tiros/tiro_normal.dart';

class Maquina {
  var rng = Random();
  var tiroEspecial = 2;
  var tirosAcertados = [];

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

  void tiroNormalMaquinaComCoordenadas(TabuleiroTiros tabuleiroTiros, int posicaoX, int posicaoY) {
    if (!tabuleiroTiros.inserirTiro(TiroTabuleiro(x: posicaoX, y: posicaoY, tiro: TiroNormal()))) {
      tiroNormalMaquina(tabuleiroTiros);
    }
  }

  void tiroEspecialMaquinaComCoordenadas(TabuleiroTiros tabuleiroTiros, int posicaoX, int posicaoY) {
    if (!tabuleiroTiros.inserirTiro(TiroTabuleiro(x: posicaoX, y: posicaoY, tiro: TiroEspecial()))) {
      tiroEspecialMaquina(tabuleiroTiros);
    }
  }

  int random(min, max) {
    return min + Random().nextInt(max - min);
  }

  List<Coordenada> nextHit(List<List<String>> tabuleiroBatalha) {
    List<Coordenada> novosTiros = [];

    for (Coordenada tiroAcertado in this.tirosAcertados) {
      Coordenada coordenadaTestaLinha = Coordenada(x: tiroAcertado.x + 1, y: tiroAcertado.y);
      Coordenada novoTiroLinha = Coordenada(x: tiroAcertado.x + 2, y: tiroAcertado.y);
      Coordenada coordenadaTestaColuna = Coordenada(x: tiroAcertado.x, y: tiroAcertado.y + 1);
      Coordenada novoTiroColuna = Coordenada(x: tiroAcertado.x, y: tiroAcertado.y + 2);

      if (this.tirosAcertados.contains(coordenadaTestaLinha) &&
          tabuleiroBatalha[novoTiroLinha.x][novoTiroLinha.y] != "V") {
        novosTiros.add(novoTiroLinha);
      } else if (this.tirosAcertados.contains(coordenadaTestaColuna) &&
          tabuleiroBatalha[novoTiroColuna.x][novoTiroColuna.y] != "V") {
        novosTiros.add(coordenadaTestaColuna);
      }
    }

    return novosTiros;
  }

  TabuleiroTiros tirosAutomaticos(TabuleiroTiros tabuleiroTiros, List<List<String>> tabuleiroBatalha) {
    var contTiros = 3;
    bool jaAtirou = false;

    for (var i = 0; i < tabuleiroBatalha.length; i++) {
      for (var j = 0; j < tabuleiroBatalha[i].length; j++) {
        if (tabuleiroBatalha[i][j] == "V") {
          tirosAcertados.add(Coordenada(x: i, y: j));
        }
      }
    }

    var novosTiros = nextHit(tabuleiroBatalha);

    if (novosTiros.isNotEmpty) {
      for (var i = 0; i < novosTiros.length || i < 3; i++) {
        if (contTiros > 0) {
          tiroNormalMaquinaComCoordenadas(tabuleiroTiros, novosTiros[i].x, novosTiros[i].y);
          contTiros--;
          jaAtirou = true;
        } else {
          return tabuleiroTiros;
        }
      }
    }

    if (tiroEspecial > 0 && usarTiroEspecial() && !jaAtirou) {
      tiroEspecialMaquina(tabuleiroTiros);
      tiroEspecial--;
      jaAtirou = true;
      return tabuleiroTiros;
    }

    for (var i = contTiros; i > 0; i--) {
      tiroNormalMaquina(tabuleiroTiros);
      contTiros--;
      jaAtirou = true;
    }

    return tabuleiroTiros;
  }

  bool usarTiroEspecial() {
    var aleatorio = rng.nextInt(10);
    if (aleatorio % 2 == 0) {
      return true;
    } else {
      return false;
    }
  }
}
