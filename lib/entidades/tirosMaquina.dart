import 'package:batalha_naval/tipos/tabuleiro/tabuleiro_tiros.dart';
import 'package:batalha_naval/tipos/tabuleiro/tiro_tabuleiro.dart';
import 'package:batalha_naval/tipos/tiros/tiro_especial.dart';
import 'package:batalha_naval/tipos/tiros/tiro_normal.dart';
import 'dart:math';

class TirosMaquina {

  var rng = Random();

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

  bool tiroNormalMaquinaComCoordenadas(
      TabuleiroTiros tabuleiroTiros, int posicaoX, int posicaoY) {
    if (!tabuleiroTiros.inserirTiro(
        TiroTabuleiro(x: posicaoX, y: posicaoY, tiro: TiroNormal()))) {
      return false;
    }
    return true;
  }

  void tiroEspecialMaquinaComCoordenadas(
      TabuleiroTiros tabuleiroTiros, int posicaoX, int posicaoY) {
    if (!tabuleiroTiros.inserirTiro(
        TiroTabuleiro(x: posicaoX, y: posicaoY, tiro: TiroEspecial()))) {
      tiroEspecialMaquina(tabuleiroTiros);
    }
  }

  int random(min, max) {
    return min + Random().nextInt(max - min);
  }

}
