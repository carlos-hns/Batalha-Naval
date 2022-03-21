import 'package:batalha_naval/tipos/coordenada.dart';
import 'package:batalha_naval/tipos/tabuleiro/tiro_tabuleiro.dart';

class TabuleiroTiros {
  late int limiteVertical;
  late int limiteHorizontal;
  late List<TiroTabuleiro> tiros;
  var tiroEspecial = 2;

  TabuleiroTiros({
    required this.limiteHorizontal,
    required this.limiteVertical,
    List<TiroTabuleiro>? tiros,
  }) : this.tiros = tiros ?? [];

  bool inserirTiro(TiroTabuleiro tiro) {
    if (!this.existeLocalExplodido(tiro)) {
      this.tiros.add(tiro);
      print(tiro.pontos);
      return true;
    }

    return false;
  }

  List<List<String>> gerarTabuleiro() {
    final tabuleiro = this._gerarTabuleiroVaio();

    tiros.forEach((tiro) {
      if (tiro.y >= 0 && tiro.y < this.limiteHorizontal && tiro.x >= 0 && tiro.x < this.limiteVertical) {
        tabuleiro[tiro.x][tiro.y] = 'X';
      }

      this._getPontosDentroDosLimites(tiro.pontos).forEach((coordenada) {
        if (tiro.y >= 0 && tiro.y < this.limiteHorizontal && tiro.x >= 0 && tiro.x < this.limiteVertical) {
          tabuleiro[coordenada.x][coordenada.y] = 'X';
        }
      });
    });

    return tabuleiro;
  }

  List<Coordenada> _getPontosDentroDosLimites(List<Coordenada> pontos) {
    final pontosFiltrados = pontos.where((ponto) {
      return ponto.x >= 0 && ponto.x < this.limiteHorizontal && ponto.y >= 0 && ponto.y < this.limiteVertical;
    }).toSet();

    return pontosFiltrados.toList();
  }

  List<List<String>> _gerarTabuleiroVaio() {
    return List.generate(this.limiteVertical, (_) => List.generate(this.limiteHorizontal, (index) => '0'));
  }

  bool existeLocalExplodido(TiroTabuleiro tiroAInserir) {
    final coordenada = Coordenada(x: tiroAInserir.x, y: tiroAInserir.y);

    final locaisExplodidos = this.tiros.where((tiroJaInserido) {
      final pontosTiroJaInserido = tiroJaInserido.pontos;

      return pontosTiroJaInserido.where((ponto) => ponto == coordenada).isNotEmpty;
    }).toList();

    return locaisExplodidos.isNotEmpty;
  }
}
