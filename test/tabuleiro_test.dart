import 'package:batalha_naval/tipos/eixo.dart';
import 'package:batalha_naval/tipos/navios/submarino.dart';
import 'package:batalha_naval/tipos/tabuleiro/navio_tabuleiro.dart';
import 'package:batalha_naval/tipos/tabuleiro/tabuleiro.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers/matriz_helper.dart';

main() {
  late Tabuleiro tabuleiro;

  setUp(() {
    tabuleiro = Tabuleiro(
      limiteHorizontal: 5,
      limiteVertical: 5,
    );
  });

  group("Criar Tabuleiro", () {
    test("Gera um tabuleiro vaio", () {
      final tabuleiroGerado = tabuleiro.gerarTabuleiro();
      final quantidadeDeZeros =
          MatrizHelper<String>().verificarQuantidadeDeElementos(tabuleiroGerado, (elemento) => elemento == '0');

      expect(quantidadeDeZeros, tabuleiro.limiteHorizontal * tabuleiro.limiteVertical);
    });
  });

  group("Inserir Navio", () {
    test("Navio adcionado com sucesso (Quantidade de navios)", () {
      tabuleiro.inserirNavio(NavioTabuleiro(
        x: 0,
        y: 0,
        eixo: Eixo.Vertical,
        navio: Submarino(),
      ));

      expect(tabuleiro.navios.length, 1);
    });

    test("Navio adcionado com sucesso (Tabuleiro gerado com Submarino)", () {
      final navio = NavioTabuleiro(
        x: 0,
        y: 0,
        eixo: Eixo.Vertical,
        navio: Submarino(),
      );

      tabuleiro.inserirNavio(navio);

      final tabuleiroGerado = tabuleiro.gerarTabuleiro();
      final quantidadeDePedacosSubmarino = MatrizHelper<String>()
          .verificarQuantidadeDeElementos(tabuleiroGerado, (elemento) => elemento == navio.navio.caracterRepresentador);

      expect(quantidadeDePedacosSubmarino, navio.navio.tamanho);
    });

    test("Adição bloqueada, já existe navio no local", () {
      tabuleiro.inserirNavio(NavioTabuleiro(
        x: 0,
        y: 0,
        eixo: Eixo.Vertical,
        navio: Submarino(),
      ));

      tabuleiro.inserirNavio(NavioTabuleiro(
        x: 0,
        y: 0,
        eixo: Eixo.Vertical,
        navio: Submarino(),
      ));

      expect(tabuleiro.navios.length, 1);
    });
  });
}
