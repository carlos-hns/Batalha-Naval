import 'dart:io';

class MatrizHelper<T> {
  int verificarQuantidadeDeElementos(List<List<T>> matriz, bool Function(T) matcher) {
    int quantidadeDeElementos = 0;

    for (int i = 0; i < matriz.length; i++) {
      for (int j = 0; j < matriz[i].length; j++) {
        if (matcher(matriz[i][j])) {
          quantidadeDeElementos++;
        }
      }
    }

    return quantidadeDeElementos;
  }

  void imprimirMatriz(List<List<T>> matriz) {
    stdout.write("\n");

    for (int i = 0; i < matriz.length; i++) {
      for (int j = 0; j < matriz[i].length; j++) {
        stdout.write("${matriz[i][j]} ");
      }
      stdout.write("\n");
    }

    stdout.write("\n");
  }
}
