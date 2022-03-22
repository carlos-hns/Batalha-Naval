import 'package:batalha_naval/tipos/coordenada.dart';
import 'dart:math';

class InteligenciaMaquina {
  var rng = Random();
  var tirosAcertados = [];

  List<Coordenada> nextHit(List<List<String>> tabuleiroBatalha, List<Coordenada> tirosAcertados) {
    List<Coordenada> tirosCandidatos = [];
    print(tirosAcertados);
    print("tirosAcertados");
    // print(tirosCandidatos);
    // tirosCandidatos.add(Coordenada(x: 9, y: 0));
    // tirosCandidatos.add(Coordenada(x: 9, y: 1));

    for (Coordenada tiroAcertado in tirosAcertados) {
      Coordenada coordenadaTestaLinha = Coordenada(x: tiroAcertado.x + 1, y: tiroAcertado.y);
      Coordenada novoTiroLinha = Coordenada(x: tiroAcertado.x + 2, y: tiroAcertado.y);
      Coordenada coordenadaTestaColuna = Coordenada(x: tiroAcertado.x, y: tiroAcertado.y + 1);
      Coordenada novoTiroColuna = Coordenada(x: tiroAcertado.x, y: tiroAcertado.y + 2);

      Coordenada coordenadaTestaLinhaMenos = Coordenada(x: tiroAcertado.x - 1, y: tiroAcertado.y);
      Coordenada novoTiroLinhaMenos = Coordenada(x: tiroAcertado.x - 2, y: tiroAcertado.y);
      Coordenada coordenadaTestaColunaMenos = Coordenada(x: tiroAcertado.x, y: tiroAcertado.y - 1);
      Coordenada novoTiroColunaMenos = Coordenada(x: tiroAcertado.x, y: tiroAcertado.y - 2);

      // if (tirosAcertados.contains(coordenadaTestaLinha) &&
      //     tabuleiroBatalha[novoTiroLinha.x][novoTiroLinha.y] != "V" &&
      //     tabuleiroBatalha[novoTiroLinha.x][novoTiroLinha.y] != "X") {
      //   tirosCandidatos.add(novoTiroLinha);
      // }
      // if (tirosAcertados.contains(coordenadaTestaColuna) &&
      //     tabuleiroBatalha[novoTiroColuna.x][novoTiroColuna.y] != "V" &&
      //     tabuleiroBatalha[novoTiroLinha.x][novoTiroLinha.y] != "X") {
      //   tirosCandidatos.add(novoTiroColuna);
      // }
      // if (tirosAcertados.contains(coordenadaTestaLinhaMenos) &&
      //     tabuleiroBatalha[novoTiroLinhaMenos.x][novoTiroLinhaMenos.y] != "V" &&
      //     tabuleiroBatalha[novoTiroLinha.x][novoTiroLinha.y] != "X") {
      //   tirosCandidatos.add(novoTiroLinhaMenos);
      // }
      // if (tirosAcertados.contains(coordenadaTestaColunaMenos) &&
      //     tabuleiroBatalha[novoTiroColunaMenos.x][novoTiroColunaMenos.y] != "V" &&
      //     tabuleiroBatalha[novoTiroLinha.x][novoTiroLinha.y] != "X") {
      //   tirosCandidatos.add(novoTiroColunaMenos);
      // }

      if (coordenadaTestaLinha.x < tabuleiroBatalha.length &&
          tabuleiroBatalha[coordenadaTestaLinha.x][coordenadaTestaLinha.y] != "V" &&
          tabuleiroBatalha[coordenadaTestaLinha.x][coordenadaTestaLinha.y] != "X") {
        tirosCandidatos.add(coordenadaTestaLinha);
      }
      if (coordenadaTestaColunaMenos.y >= 0 &&
          tabuleiroBatalha[coordenadaTestaColunaMenos.x][coordenadaTestaColunaMenos.y] != "V" &&
          tabuleiroBatalha[coordenadaTestaColunaMenos.x][coordenadaTestaColunaMenos.y] != "X") {
        tirosCandidatos.add(coordenadaTestaColunaMenos);
      }
      if (coordenadaTestaColuna.y < tabuleiroBatalha.length &&
          tabuleiroBatalha[coordenadaTestaColuna.x][coordenadaTestaColuna.y] != "V" &&
          tabuleiroBatalha[coordenadaTestaColuna.x][coordenadaTestaColuna.y] != "V") {
        tirosCandidatos.add(coordenadaTestaColuna);
      }
      if (coordenadaTestaLinhaMenos.x >= 0 &&
          tabuleiroBatalha[coordenadaTestaLinhaMenos.x][coordenadaTestaLinhaMenos.y] != "V" &&
          tabuleiroBatalha[coordenadaTestaLinhaMenos.x][coordenadaTestaLinhaMenos.y] != "X") {
        tirosCandidatos.add(coordenadaTestaLinhaMenos);
      }
      // var tiroVIsolado = rng.nextInt(4);
      // switch (tiroVIsolado) {
      //   case 1:
      //     {
      //       tirosCandidatos.add(coordenadaTestaLinha);
      //     }
      //     break;
      //   case 2:
      //     {
      //       tirosCandidatos.add(coordenadaTestaColuna);
      //     }
      //     break;
      //   case 3:
      //     {
      //       tirosCandidatos.add(coordenadaTestaLinhaMenos);
      //     }
      //     break;
      //   case 4:
      //     {
      //       tirosCandidatos.add(coordenadaTestaColunaMenos);
      //     }
      //     break;
      //

    }
    print("novos tiros:");
    print(tirosCandidatos);
    // List<Coordenada> tirosCandidatosLimpos = limpaTirosCandidatos(tirosCandidatos);
    // print(tirosCandidatosLimpos);

    return limpaTirosCandidatos(tirosCandidatos, tabuleiroBatalha);
  }

  List<Coordenada> limpaTirosCandidatos(List<Coordenada> tirosCandidatos, List<List<String>> tabuleiroBatalha) {
    List<Coordenada> tirosCandidatosLimpos = [];
    for (var tiroCandidato in tirosCandidatos) {
      if (tabuleiroBatalha[tiroCandidato.x][tiroCandidato.y] != "V" &&
          tabuleiroBatalha[tiroCandidato.x][tiroCandidato.y] != "X" &&
          tabuleiroBatalha[tiroCandidato.x][tiroCandidato.y] != "S" &&
          tabuleiroBatalha[tiroCandidato.x][tiroCandidato.y] != "C" &&
          tabuleiroBatalha[tiroCandidato.x][tiroCandidato.y] != "T" &&
          tabuleiroBatalha[tiroCandidato.x][tiroCandidato.y] != "P" &&
          tiroCandidato.x >= 0 &&
          tiroCandidato.x < tabuleiroBatalha.length &&
          tiroCandidato.y >= 0 &&
          tiroCandidato.y < tabuleiroBatalha.length) {
        tirosCandidatosLimpos.add(tiroCandidato);
      }
    }
    return tirosCandidatosLimpos;
  }
}
