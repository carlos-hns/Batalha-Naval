import 'dart:io';

enum Eixo {
  Vertical,
  Horizontal,
}

/* abstract */ class Navio {
  late int tamanho;
  Navio({required this.tamanho});
}

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

class Tabuleiro {
  late int limiteVertical;
  late int limiteHorizontal;
  late List<NavioTabuleiro> navios = [];

  Tabuleiro({
    required this.limiteHorizontal,
    required this.limiteVertical,
    //List<Navio>? navios,
  }); //: this.navios = navios ?? [];

  List<List<String>> _gerarTabuleiroVaio() {
    return List.generate(this.limiteVertical, (_) => List.generate(this.limiteHorizontal, (index) => '0'));
  }

  //List<List<String>> _desenharTabuleiro() {}

  bool inserirNavio(NavioTabuleiro navio) {
    final navioEstaDentroDosLimites = navio.eixo == Eixo.Vertical
        ? this._navioEstaDentroDoLimiteVertical(navio)
        : this._navioEstaDentroDoLimiteHorizontal(navio);

    //print(navioEstaDentroDosLimites);
    //print(!this.existeOutroNavioNaPosicao(navio));

    //print("Ja existe: ${this.existeOutroNavioNaPosicao(navio)}\n");

    if (navioEstaDentroDosLimites && !this.existeOutroNavioNaPosicao(navio)) {
      this.navios.add(navio);
      return true;
    }

    return false;
  }

  bool _navioEstaDentroDoLimiteVertical(NavioTabuleiro navioTabuleiro) {
    final tamanhoReal = navioTabuleiro.y + navioTabuleiro.navio.tamanho;
    return tamanhoReal > 0 && tamanhoReal < this.limiteVertical;
  }

  bool _navioEstaDentroDoLimiteHorizontal(NavioTabuleiro navioTabuleiro) {
    final tamanhoReal = navioTabuleiro.x + navioTabuleiro.navio.tamanho;
    return tamanhoReal > 0 && tamanhoReal < this.limiteHorizontal;
  }

  bool existeOutroNavioNaPosicao(NavioTabuleiro navioAInserir) {
    final naviosComConflito = this.navios.where((navioJaInserido) {
      // print("X Inserir: ${navioAInserir.x}");
      // print("X Ja: ${navioJaInserido.x}");
      // print("X Inserir Final: ${navioJaInserido.posicaoFinalX}");
      // print("X Ja Final: ${navioJaInserido.posicaoFinalX}\n");

      // print("Y Inserir: ${navioAInserir.y}");
      // print("Y Ja: ${navioJaInserido.y}");
      // print("Y Inserir Final: ${navioJaInserido.posicaoFinalY}");
      // print("Y Ja Final: ${navioJaInserido.posicaoFinalY}\n");

      // print((navioAInserir.x >= navioJaInserido.x && navioAInserir.posicaoFinalX <= navioJaInserido.posicaoFinalX));
      // print((navioAInserir.y >= navioJaInserido.y && navioAInserir.posicaoFinalY <= navioJaInserido.posicaoFinalY));

      return (navioAInserir.x >= navioJaInserido.x && navioAInserir.posicaoFinalX <= navioJaInserido.posicaoFinalX) ||
          (navioAInserir.y >= navioJaInserido.y && navioAInserir.posicaoFinalY <= navioJaInserido.posicaoFinalY);
    }).toList();

    //print(naviosComConflito);
    return naviosComConflito.length >= 1;
  }

  void imprimirTabuleiro() {
    final tabuleiro = this._gerarTabuleiroVaio();

    stdout.write("\n");

    for (int i = 0; i < limiteVertical; i++) {
      for (int j = 0; j < limiteHorizontal; j++) {
        stdout.write(tabuleiro[i][j] + " ");
      }
      stdout.write("\n");
    }
    stdout.write("\n");
  }
}

main() {
  // , navios: [
  //   Navio(eixo: Eixo.Vertical, tamanho: 3),
  //   Navio(eixo: Eixo.Horizontal, tamanho: 4),
  // ]

  Tabuleiro(limiteHorizontal: 6, limiteVertical: 5)..imprimirTabuleiro();
}
