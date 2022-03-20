import 'package:batalha_naval/tipos/tiros/tiro.dart';

import '../coordenada.dart';

class TiroTabuleiro {
  int x, y;
  Tiro tiro;

  List<Coordenada> get pontos => this._getCoordenadas();

  TiroTabuleiro({
    required this.x,
    required this.y,
    required this.tiro,
  });

  List<Coordenada> _getCoordenadas() {
    final List<Coordenada> coordenadas = [];

    for (int i = 0; i < tiro.raioDeTiro + 1; i++) {
      coordenadas.addAll(this._getPontos(x, y, i));
    }

    return coordenadas;
  }

  List<Coordenada> _getPontos(int x, int y, int raio) {
    return [
      Coordenada(x: x, y: y),
      Coordenada(x: x, y: y + raio),
      Coordenada(x: x + raio, y: y + raio),
      Coordenada(x: x + raio, y: y),
      Coordenada(x: x + raio, y: y - raio),
      Coordenada(x: x, y: y - raio),
      Coordenada(x: x - raio, y: y - raio),
      Coordenada(x: x - raio, y: y),
      Coordenada(x: x - raio, y: y + raio),
    ];
  }

  @override
  String toString() {
    return "(${this.x}, ${this.y})";
  }
}
