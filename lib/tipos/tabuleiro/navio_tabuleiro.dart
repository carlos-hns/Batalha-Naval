import 'package:batalha_naval/tipos/eixo.dart';
import 'package:batalha_naval/tipos/navios/navio.dart';

/// Provavelmente vamos precisar usar um caracter pra representar o navio
class NavioTabuleiro {
  int x, y;

  /// Se você passar o eixo como Vertical a coordenada em X servirá apenas como constante.
  /// Se você passar o eixo como Horizontal a coordenada Y servirá apenas como constante.
  ///
  /// Em ambos os casos a variação é dada pelo termo que não é constante e o navio será
  /// mostrado no eixo escolhido a partir do termo que variante.
  Eixo eixo;
  Navio navio;

  NavioTabuleiro({
    required this.x,
    required this.y,
    required this.eixo,
    required this.navio,
  });

  int get posicaoFinalX => this.x + this.navio.tamanho;
  int get posicaoFinalY => this.y + this.navio.tamanho;
}
