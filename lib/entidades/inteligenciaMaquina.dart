import 'package:batalha_naval/tipos/coordenada.dart';
import 'dart:math';

class InteligenciaMaquina {
  var rng = Random();
  var tirosAcertados = [];

  List<Coordenada> nextHit(
      List<List<String>> tabuleiroBatalha, tirosAcertados) {
    List<Coordenada> tirosCandidatos = [];
    print("tirosAcertados");
    print(tirosAcertados);
    print(tirosCandidatos);
    tirosCandidatos.add(Coordenada(x: 9, y: 0));
    tirosCandidatos.add(Coordenada(x: 9, y: 1));

    for (Coordenada tiroAcertado in tirosAcertados) {
      Coordenada coordenadaTestaLinha =
          Coordenada(x: tiroAcertado.x + 1, y: tiroAcertado.y);
      Coordenada novoTiroLinha =
          Coordenada(x: tiroAcertado.x + 2, y: tiroAcertado.y);
      Coordenada coordenadaTestaColuna =
          Coordenada(x: tiroAcertado.x, y: tiroAcertado.y + 1);
      Coordenada novoTiroColuna =
          Coordenada(x: tiroAcertado.x, y: tiroAcertado.y + 2);

      Coordenada coordenadaTestaLinhaMenos =
          Coordenada(x: tiroAcertado.x - 1, y: tiroAcertado.y);
      Coordenada novoTiroLinhaMenos =
          Coordenada(x: tiroAcertado.x - 2, y: tiroAcertado.y);
      Coordenada coordenadaTestaColunaMenos =
          Coordenada(x: tiroAcertado.x, y: tiroAcertado.y - 1);
      Coordenada novoTiroColunaMenos =
          Coordenada(x: tiroAcertado.x, y: tiroAcertado.y - 2);

      if (tirosAcertados.contains(coordenadaTestaLinha) &&
          tabuleiroBatalha[novoTiroLinha.x][novoTiroLinha.y] != "V") {
        tirosCandidatos.add(novoTiroLinha);
      } else if (tirosAcertados.contains(coordenadaTestaColuna) &&
          tabuleiroBatalha[novoTiroColuna.x][novoTiroColuna.y] != "V") {
        tirosCandidatos.add(novoTiroColuna);
      } else if (tirosAcertados.contains(coordenadaTestaLinhaMenos) &&
          tabuleiroBatalha[novoTiroLinhaMenos.x][novoTiroLinhaMenos.y] != "V") {
        tirosCandidatos.add(novoTiroLinhaMenos);
      } else if (tirosAcertados.contains(coordenadaTestaColunaMenos) &&
          tabuleiroBatalha[novoTiroColunaMenos.x][novoTiroColunaMenos.y] !=
              "V") {
        tirosCandidatos.add(novoTiroColunaMenos);
      } else {
        var tiroVIsolado = rng.nextInt(4);
        switch (tiroVIsolado) {
          case 1:
            {
              tirosCandidatos.add(coordenadaTestaLinha);
            }
            break;
          case 2:
            {
              tirosCandidatos.add(coordenadaTestaColuna);
            }
            break;
          case 3:
            {
              tirosCandidatos.add(coordenadaTestaLinhaMenos);
            }
            break;
          case 4:
            {
              tirosCandidatos.add(coordenadaTestaColunaMenos);
            }
            break;
        }
      }
    }
    print("novos tiros:");
    print(tirosCandidatos);

    return tirosCandidatos;
  }
}
