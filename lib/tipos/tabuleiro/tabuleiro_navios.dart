import 'package:batalha_naval/tipos/eixo.dart';
import 'package:batalha_naval/tipos/tabuleiro/navio_tabuleiro.dart';
import 'package:batalha_naval/utilidades/matriz_helper.dart';

class TabuleiroNavios {
  late int limiteVertical;
  late int limiteHorizontal;
  late List<NavioTabuleiro> navios;

  TabuleiroNavios({
    required this.limiteHorizontal,
    required this.limiteVertical,
    List<NavioTabuleiro>? navios,
  }) : this.navios = navios ?? [];

  List<List<String>> gerarTabuleiro() {
    final tabuleiro = this._gerarTabuleiroVazio();

    this.navios.forEach((navio) {
      navio.eixo == Eixo.Horizontal
          ? _desenharNavioVertical(tabuleiro, navio)
          : _desenharNavioHorizontal(tabuleiro, navio);
    });

    return tabuleiro;
  }

  bool inserirNavio(NavioTabuleiro navio) {
    final navioEstaDentroDosLimites = navio.eixo == Eixo.Vertical
        ? this._navioEstaDentroDoLimiteVertical(navio)
        : this._navioEstaDentroDoLimiteHorizontal(navio);

    if (navioEstaDentroDosLimites && !this._existeOutroNavioNaPosicao(navio)) {
      this.navios.add(navio);
      print(navio.eixo);
      print(navio.pontos);
      print("NAVIO INSERIDO!!!");
      return true;
    }

    return false;
  }

  List<List<String>> _gerarTabuleiroVazio() {
    return List.generate(this.limiteVertical, (_) => List.generate(this.limiteHorizontal, (index) => '0'));
  }

  void _desenharNavioVertical(List<List<String>> tabuleiro, NavioTabuleiro navio) {
    final coordenadas = List.generate(navio.posicaoFinalY - navio.y, (variacao) => [variacao + navio.y, navio.x]);

    coordenadas.forEach((coordenada) {
      int coordenadaX = coordenada[1];
      int coordenadaY = coordenada[0];
      tabuleiro[coordenadaX][coordenadaY] = navio.navio.caracterRepresentador;
    });
  }

  void _desenharNavioHorizontal(List<List<String>> tabuleiro, NavioTabuleiro navio) {
    final coordenadas = List.generate(navio.posicaoFinalX - navio.x, (variacao) => [navio.y, navio.x + variacao]);

    coordenadas.forEach((coordenada) {
      int coordenadaX = coordenada[1];
      int coordenadaY = coordenada[0];
      tabuleiro[coordenadaX][coordenadaY] = navio.navio.caracterRepresentador;
    });
  }

  bool _navioEstaDentroDoLimiteVertical(NavioTabuleiro navioTabuleiro) {
    final tamanhoReal = navioTabuleiro.x + navioTabuleiro.navio.tamanho;
    return tamanhoReal > 0 && tamanhoReal <= this.limiteVertical;
  }

  bool _navioEstaDentroDoLimiteHorizontal(NavioTabuleiro navioTabuleiro) {
    final tamanhoReal = navioTabuleiro.y + navioTabuleiro.navio.tamanho;
    return tamanhoReal > 0 && tamanhoReal <= this.limiteHorizontal;
  }

  bool _existeOutroNavioNaPosicao(NavioTabuleiro navioAInserir) {
    final naviosComConflito = this.navios.where((navioJaInserido) {
      final pontosNavioJaInserido = navioJaInserido.pontos;
      final pontosNavioAInserir = navioAInserir.pontos;

      // print("pontos navio a inserir: ");
      // print((navioAInserir.pontos).toList());
      // print("pontos navio ja inserido: ");
      // print((navioJaInserido.pontos).toList());
      //final prontosDoNavio = navioAInserir.coordenadasDoNavio();
      return pontosNavioAInserir.where((ponto) => pontosNavioJaInserido.contains(ponto)).isNotEmpty;
    }).toList();

    return naviosComConflito.isNotEmpty;
  }
}
