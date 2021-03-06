import 'package:batalha_naval/base/base_view.dart';
import 'package:batalha_naval/entidades/maquina.dart';
import 'package:batalha_naval/utilidades/matriz_helper.dart';
import 'package:batalha_naval/view_models/pagina_testes_view_model.dart';
import 'package:flutter/material.dart';

import '../tipos/tabuleiro/tabuleiro_tiros.dart';

class PaginaTestes extends StatelessWidget {
  const PaginaTestes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<PaginaTestesViewModel>(
      onInitState: (viewModel) {
        final limites = 15;
        final tabuleiroMaquina = Maquina().geraTabuleiroMaquina(limites, limites);
        MatrizHelper().imprimirMatriz(tabuleiroMaquina.gerarTabuleiro());

        var tabuleiroTiro = Maquina().geraTabuleiroTiroMaquina(15, 15);

        MatrizHelper().imprimirMatriz(tabuleiroTiro.gerarTabuleiro());

        var tabuleiroDeBatalha =
            tabuleiroMaquina.mesclarTabuleiroDeNaviosComTiros(tabuleiroMaquina, tabuleiroTiro.gerarTabuleiro());

        Maquina().tirosAutomaticos(tabuleiroTiro, tabuleiroDeBatalha);

        tabuleiroDeBatalha =
            tabuleiroMaquina.mesclarTabuleiroDeNaviosComTiros(tabuleiroMaquina, tabuleiroTiro.gerarTabuleiro());
        MatrizHelper().imprimirMatriz(tabuleiroDeBatalha);
        Maquina().tirosAutomaticos(tabuleiroTiro, tabuleiroDeBatalha);
        tabuleiroDeBatalha =
            tabuleiroMaquina.mesclarTabuleiroDeNaviosComTiros(tabuleiroMaquina, tabuleiroTiro.gerarTabuleiro());
        MatrizHelper().imprimirMatriz(tabuleiroDeBatalha);
        Maquina().tirosAutomaticos(tabuleiroTiro, tabuleiroDeBatalha);
        tabuleiroDeBatalha =
            tabuleiroMaquina.mesclarTabuleiroDeNaviosComTiros(tabuleiroMaquina, tabuleiroTiro.gerarTabuleiro());
        MatrizHelper().imprimirMatriz(tabuleiroDeBatalha);
        Maquina().tirosAutomaticos(tabuleiroTiro, tabuleiroDeBatalha);
        
        // List<List<String>> tabuleiroMaquina2 = tabuleiroMaquina.gerarTabuleiro();
        //tabuleiroMaquina2 = tabuleiroTiro.gerarTabuleiro();
      },
      builder: (context, viewModel) {
        return Container();
      },
    );
  }
}
