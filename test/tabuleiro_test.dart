import 'package:batalha_naval/tipos/eixo.dart';
import 'package:batalha_naval/tipos/navios/submarino.dart';
import 'package:batalha_naval/tipos/tabuleiro/navio_tabuleiro.dart';
import 'package:batalha_naval/tipos/tabuleiro/tabuleiro.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  late Tabuleiro tabuleiro;

  setUp(() {
    tabuleiro = Tabuleiro(
      limiteHorizontal: 5,
      limiteVertical: 5,
    );
  });

  group("Inserir Navio", () {
    test("Navio adcionado com sucesso", () {
      tabuleiro.inserirNavio(NavioTabuleiro(
        x: 0,
        y: 0,
        eixo: Eixo.Vertical,
        navio: Submarino(),
      ));

      expect(tabuleiro.navios.length, 1);
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
