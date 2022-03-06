import 'package:batalha_naval/tipos/coordenada.dart';
import 'package:batalha_naval/tipos/eixo.dart';
import 'package:batalha_naval/tipos/navios/navio.dart';

class NavioTabuleiro {
  int x, y;

  /// Se você passar o eixo como Vertical a coordenada em X servirá apenas como constante.
  /// Se você passar o eixo como Horizontal a coordenada Y servirá apenas como constante.
  ///
  /// Em ambos os casos a variação é dada pelo termo que não é constante e o navio será
  /// mostrado no eixo escolhido a partir do termo que variante.
  Eixo eixo;
  Navio navio;

  int get posicaoFinalX => this.x + this.navio.tamanho;
  int get posicaoFinalY => this.y + this.navio.tamanho;

  List<Coordenada> get pontos => this._getCoordenadas();

  NavioTabuleiro({
    required this.x,
    required this.y,
    required this.eixo,
    required this.navio,
  });

  List<Coordenada> _getCoordenadas() {
    if (this.eixo == Eixo.Horizontal) {
      return List.generate(this.navio.tamanho, (index) => Coordenada(x: index, y: this.y));
    }

    return List.generate(this.navio.tamanho, (index) => Coordenada(x: this.x, y: index));
  }

  @override
  String toString() {
    return "(${this.x}, ${this.y}) - (${this.posicaoFinalX}, ${this.posicaoFinalY}) - ${this.eixo.name}";
  }
}
