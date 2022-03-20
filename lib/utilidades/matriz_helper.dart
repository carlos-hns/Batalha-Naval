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
    print("\n");
    String linha = "";
    for (int i = 0; i < matriz.length; i++) {
      for (int j = 0; j < matriz[i].length; j++) {
        linha += "${matriz[i][j]} ";
      }
      print(linha + i.toString() + "\n");
      linha = "";
    }
    print("\n");
  }
}
