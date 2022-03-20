import 'package:batalha_naval/base/base_view.dart';
import 'package:batalha_naval/entidades/maquina.dart';
import 'package:batalha_naval/utilidades/matriz_helper.dart';
import 'package:batalha_naval/view_models/pagina_testes_view_model.dart';
import 'package:flutter/material.dart';

class PaginaTestes extends StatelessWidget {
  const PaginaTestes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<PaginaTestesViewModel>(
      onInitState: (viewModel) {
        final tabuleiroMaquina = Maquina().geraTabuleiroMaquina(15, 15);
        MatrizHelper().imprimirMatriz(tabuleiroMaquina.gerarTabuleiro());

        final tabuleiroTiro = Maquina().geraTabuleiroTiroMaquina(15, 15);

        MatrizHelper().imprimirMatriz(tabuleiroTiro.gerarTabuleiro());

        // List<List<String>> tabuleiroMaquina2 = tabuleiroMaquina.gerarTabuleiro();
        //tabuleiroMaquina2 = tabuleiroTiro.gerarTabuleiro();
      },
      builder: (context, viewModel) {
        return Container();
      },
    );
  }
}
