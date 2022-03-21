import 'package:batalha_naval/entidades/inteligenciaMaquina.dart';
import 'package:batalha_naval/tipos/coordenada.dart';
import 'package:batalha_naval/tipos/tabuleiro/tabuleiro_navios.dart';
import 'package:batalha_naval/tipos/tabuleiro/tabuleiro_tiros.dart';
import 'package:batalha_naval/entidades/naviosMaquina.dart';
import 'package:batalha_naval/entidades/tirosMaquina.dart';
import 'dart:math';

class Maquina {
  var rng = Random();

  var tirosAcertados = [];

  TabuleiroNavios geraTabuleiroMaquina(
      int limiteHorizontal, int limiteVertical) {
    var tabuleiroNavio = TabuleiroNavios(
        limiteHorizontal: limiteHorizontal, limiteVertical: limiteVertical);

    NaviosMaquina naviosMaquina = NaviosMaquina();
    naviosMaquina.gerarPortaAviaoMaquina(tabuleiroNavio);
    naviosMaquina.gerarNavioTanqueMaquina(tabuleiroNavio);
    naviosMaquina.gerarNavioTanqueMaquina(tabuleiroNavio);
    naviosMaquina.gerarContratorpedeirosMaquina(tabuleiroNavio);
    naviosMaquina.gerarContratorpedeirosMaquina(tabuleiroNavio);
    naviosMaquina.gerarContratorpedeirosMaquina(tabuleiroNavio);
    naviosMaquina.gerarSubmarinosMaquina(tabuleiroNavio);
    naviosMaquina.gerarSubmarinosMaquina(tabuleiroNavio);
    naviosMaquina.gerarSubmarinosMaquina(tabuleiroNavio);
    naviosMaquina.gerarSubmarinosMaquina(tabuleiroNavio);

    return tabuleiroNavio;
  }

  TabuleiroTiros geraTabuleiroTiroMaquina(int tamanhoH, int tamanhoV) {
    var tabuleiroTiros =
        TabuleiroTiros(limiteHorizontal: tamanhoH, limiteVertical: tamanhoV);
    return tabuleiroTiros;
  }

  // On playing #################################################################

  TabuleiroTiros tirosAutomaticos(
      TabuleiroTiros tabuleiroTiros, List<List<String>> tabuleiroBatalha) {
    TirosMaquina tirosMaquina = TirosMaquina();
    InteligenciaMaquina inteligenciaMaquina = InteligenciaMaquina();

    var contTiros = 3;
    bool jaAtirou = false;

    for (var i = 0; i < tabuleiroBatalha.length; i++) {
      for (var j = 0; j < tabuleiroBatalha[i].length; j++) {
        if (tabuleiroBatalha[i][j] == "V") {
          tirosAcertados.add(Coordenada(x: i, y: j));
        }
      }
    }

    var novosTiros =
        inteligenciaMaquina.nextHit(tabuleiroBatalha, tirosAcertados);
    this.tirosAcertados = [];

    if (novosTiros.isNotEmpty) {
      for (var i = 0; i < novosTiros.length; i++) {
        if (contTiros > 0) {
          bool testaTiro = tirosMaquina.tiroNormalMaquinaComCoordenadas(
              tabuleiroTiros, novosTiros[i].x, novosTiros[i].y);
          if (testaTiro) {
            contTiros--;
            jaAtirou = true;
          }
        }
      }
    }

    if (tabuleiroTiros.tiroEspecial > 0 && usarTiroEspecial() && !jaAtirou) {
      tirosMaquina.tiroEspecialMaquina(tabuleiroTiros);
      tabuleiroTiros.tiroEspecial--;
      jaAtirou = true;
      return tabuleiroTiros;
    }

    for (var i = contTiros; i > 0; i--) {
      tirosMaquina.tiroNormalMaquina(tabuleiroTiros);
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
