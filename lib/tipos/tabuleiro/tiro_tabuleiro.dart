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
    return List.generate(tiro.raioDeTiro, (index) => index + 1).fold([], (acc, nextValue) {
      return [
        ...acc,
        ...this._getPontos(this.x, this.y, nextValue),
      ];
    });
  }

  List<Coordenada> _getPontos(int x, int y, int raio) {
    final array = [
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
    return array;
  }

  @override
  String toString() {
    return "(${this.x}, ${this.y})";
  }
}
