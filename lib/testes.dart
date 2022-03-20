import 'package:batalha_naval/utilidades/matriz_helper.dart';
import 'entidades/maquina.dart';

main() {
  final tabuleiroMaquina = Maquina().geraTabuleiroMaquina(15, 15);
//  MatrizHelper().imprimirMatriz(tabuleiroMaquina.gerarTabuleiro());

  final tabuleiroTiro = Maquina().geraTabuleiroTiroMaquina(15, 15);

  MatrizHelper().imprimirMatriz(tabuleiroTiro.gerarTabuleiro());

  List<List<String>> tabuleiroMaquina2 = tabuleiroMaquina.gerarTabuleiro();
  //tabuleiroMaquina2 = tabuleiroTiro.gerarTabuleiro();

  MatrizHelper().imprimirMatriz(tabuleiroMaquina2);
}
