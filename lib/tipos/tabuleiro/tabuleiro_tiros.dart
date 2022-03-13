import 'package:batalha_naval/tipos/coordenada.dart';
import 'package:batalha_naval/tipos/tabuleiro/tiro_tabuleiro.dart';

class TabuleiroTiros {
  late int limiteVertical;
  late int limiteHorizontal;
  late List<TiroTabuleiro> tiros;

  TabuleiroTiros({
    required this.limiteHorizontal,
    required this.limiteVertical,
    List<TiroTabuleiro>? tiros,
  }) : this.tiros = tiros ?? [];

  bool inserirTiro(TiroTabuleiro tiro) {
    if (!this._existeLocalExplodido(tiro)) {
      this.tiros.add(tiro);
      return true;
    }

    return false;
  }

  List<List<String>> gerarTabuleiro() {
    final tabuleiro = this._gerarTabuleiroVaio();

    tiros.forEach((tiro) {
      tabuleiro[tiro.y][tiro.x] = 'x';
      tiro.pontos.forEach((coordenada) {
        if (tiro.x >= 0 && tiro.x <= this.limiteHorizontal && tiro.y >= 0 && tiro.y <= this.limiteVertical) {
          tabuleiro[coordenada.y][coordenada.x] = 'x';
        }
      });
    });

    return tabuleiro;
  }

  List<List<String>> _gerarTabuleiroVaio() {
    return List.generate(this.limiteVertical, (_) => List.generate(this.limiteHorizontal, (index) => '0'));
  }

  bool _existeLocalExplodido(TiroTabuleiro tiroAInserir) {
    final coordenada = Coordenada(x: tiroAInserir.x, y: tiroAInserir.y);

    final locaisExplodidos = this.tiros.where((tiroJaInserido) {
      final pontosTiroJaInserido = tiroJaInserido.pontos;

      return pontosTiroJaInserido.where((ponto) => ponto == coordenada).isNotEmpty;
    }).toList();

    return locaisExplodidos.isNotEmpty;
  }
}
