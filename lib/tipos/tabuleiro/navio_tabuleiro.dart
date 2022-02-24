import 'package:batalha_naval/tipos/eixo.dart';
import 'package:batalha_naval/tipos/navios/navio.dart';

/// Provavelmente vamos precisar usar um caracter pra representar o navio
class NavioTabuleiro {
  int x, y;
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
