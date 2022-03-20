import 'package:batalha_naval/tipos/coordenada.dart';
import 'package:batalha_naval/tipos/eixo.dart';
import 'package:batalha_naval/tipos/tabuleiro/navio_tabuleiro.dart';

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

  List<List<String>> gerarTabuleiroComTiros(TabuleiroNavios tabuleiro, List<List<String>> tiros) {
    List<List<String>> novoTabuleiro = tabuleiro.gerarTabuleiro();
    for (int i = 0; i < novoTabuleiro.length; i++) {
      for (int j = 0; j < novoTabuleiro[i].length; j++) {
        if (tiros[i][j] == "X") {
          if (novoTabuleiro[i][j] != "0") {
            novoTabuleiro[i][j] = "V";
            print("Hum, Acertou miseravi!");
          } else {
            novoTabuleiro[i][j] = tiros[i][j];
          }
        }
      }
    }
    novoTabuleiro = naviosAfundados(tabuleiro, novoTabuleiro);
    return novoTabuleiro;
  }

  List<List<String>> naviosAfundados(TabuleiroNavios tabuleiroOriginal, List<List<String>> novoTabuleiro) {
    final naviosAfundados = tabuleiroOriginal.navios.where((navio) {
      final pontos = navio.pontos;
      bool foiAfundado = true;
      pontos.forEach((ponto) {
        if (novoTabuleiro[ponto.x][ponto.y] == "V") {
          foiAfundado = foiAfundado && true;
        } else {
          foiAfundado = foiAfundado && false;
        }
      });
      return foiAfundado;
    }).toList();
    naviosAfundados.forEach((navio) {
      navio.pontos.forEach((ponto) {
        novoTabuleiro[ponto.x][ponto.y] = _tiposNaviosAfundados(navio.navio.caracterRepresentador);
      });
    });

    return novoTabuleiro;
  }

  String _tiposNaviosAfundados(String caractere) {
    switch (caractere) {
      case "5":
        return "P";
      case "4":
        return "T";
      case "3":
        return "C";
      case "2":
        return "S";
      default:
        "Z";
    }
    return caractere;
  }

  bool inserirNavio(NavioTabuleiro navio) {
    final navioEstaDentroDosLimites = navio.eixo == Eixo.Vertical
        ? this._navioEstaDentroDoLimiteVertical(navio)
        : this._navioEstaDentroDoLimiteHorizontal(navio);

    if (navioEstaDentroDosLimites && !this._existeOutroNavioNaPosicao(navio)) {
      print(navio.pontos);
      this.navios.add(navio);
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

      return pontosNavioAInserir.where((ponto) => pontosNavioJaInserido.contains(ponto)).isNotEmpty;
    }).toList();

    return naviosComConflito.isNotEmpty;
  }
}
