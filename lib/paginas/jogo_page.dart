import 'package:batalha_naval/app_colors.dart';
import 'package:batalha_naval/base/base_view.dart';
import 'package:batalha_naval/componentes/tabuleiro/batalha_board.dart';
import 'package:batalha_naval/tipos/tabuleiro/tabuleiro_navios.dart';
import 'package:batalha_naval/view_models/jogo_view_model.dart';
import 'package:flutter/material.dart';
import 'package:rx_widgets/rx_widgets.dart';

class JogoPage extends StatelessWidget {
  TabuleiroNavios tabuleiroNavios;

  JogoPage({
    required this.tabuleiroNavios,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<JogoViewModel>(
      builder: (context, viewModel) {
        return Scaffold(
          backgroundColor: PrimaryColor,
          body: Row(
            children: [
              this._sideBar(context, viewModel),
              Expanded(
                child: BatalhaBoard(
                  x: tabuleiroNavios.limiteHorizontal,
                  y: tabuleiroNavios.limiteVertical,
                  //tilesInfo: viewModel.infos(),
                  onTapItem: (coordenada) {
                    //viewModel.adicionarNavioCommand(coordenada);
                  },
                ),
              ),
              Expanded(
                child: BatalhaBoard(
                  x: tabuleiroNavios.limiteHorizontal,
                  y: tabuleiroNavios.limiteVertical,
                  //tilesInfo: viewModel.infos(),
                  onTapItem: (coordenada) {
                    //viewModel.adicionarNavioCommand(coordenada);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _sideBar(BuildContext context, JogoViewModel viewModel) {
    return Container(
      color: Color(0xFF222623),
      width: MediaQuery.of(context).size.width * 0.3,
      child: ReactiveBuilder(
        stream: viewModel.isBusy,
        builder: (context, data) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                "Teste",
                style: TextStyle(
                  color: TextColor,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
