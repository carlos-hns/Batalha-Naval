import 'package:batalha_naval/tipos/eixo.dart';
import 'package:batalha_naval/tipos/navios/submarino.dart';
import 'package:batalha_naval/tipos/tabuleiro/navio_tabuleiro.dart';
import 'package:batalha_naval/tipos/tabuleiro/tabuleiro_navios.dart';
import 'package:batalha_naval/utilidades/matriz_helper.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  late TabuleiroNavios tabuleiro;

  setUp(() {
    tabuleiro = TabuleiroNavios(
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

    test("Dois návios adcionados com sucesso (Quantidade de navios)", () {
      tabuleiro.inserirNavio(NavioTabuleiro(
        x: 0,
        y: 0,
        eixo: Eixo.Vertical,
        navio: Submarino(),
      ));

      tabuleiro.inserirNavio(NavioTabuleiro(
        x: 2,
        y: 0,
        eixo: Eixo.Vertical,
        navio: Submarino(),
      ));

      expect(tabuleiro.navios.length, 2);
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

    test("Adição bloqueada, já existe navio no local 1", () {
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

    test("Adição bloqueada, já existe navio no local 2", () {
      tabuleiro.inserirNavio(NavioTabuleiro(
        x: 0,
        y: 0,
        eixo: Eixo.Horizontal,
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
