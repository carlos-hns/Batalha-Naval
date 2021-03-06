import 'package:batalha_naval/tipos/coordenada.dart';
import 'package:batalha_naval/tipos/eixo.dart';
import 'package:batalha_naval/tipos/navios/navio.dart';

class NavioTabuleiro {
  int x, y;
  Eixo eixo;
  Navio navio;

  int get posicaoFinalX => eixo == Eixo.Horizontal ? this.x : this.x + this.navio.tamanho;
  int get posicaoFinalY => eixo == Eixo.Vertical ? this.y : this.y + this.navio.tamanho;

  List<Coordenada> get pontos => this._getCoordenadas();
  bool contemPonto(Coordenada ponto) => this.pontos.where((pontoContido) => ponto == pontoContido).isNotEmpty;

  NavioTabuleiro({
    required this.x,
    required this.y,
    required this.eixo,
    required this.navio,
  });

  List<Coordenada> _getCoordenadas() {
    if (this.eixo == Eixo.Vertical) {
      return List.generate(this.navio.tamanho, (index) => Coordenada(x: index + this.x, y: this.y));
    }

    return List.generate(this.navio.tamanho, (index) => Coordenada(x: this.x, y: index + this.y));
  }

  List<List<int>> coordenadasDoNavio() {
    if (this.eixo == Eixo.Vertical) {
      List<List<int>> coordenadas = List.empty();
      for (int i = 0; i < this.navio.tamanho; i++) {
        coordenadas.add([this.x + i, this.y]);
      }
      return coordenadas;
    } else {
      List<List<int>> coordenadas = List.empty();
      for (int i = 0; i < this.navio.tamanho; i++) {
        coordenadas.add([this.x, this.y + i]);
      }
      return coordenadas;
    }
  }

  @override
  String toString() {
    return "(${this.x}, ${this.y}) - (${this.posicaoFinalX}, ${this.posicaoFinalY}) - ${this.eixo.name}";
  }
}
