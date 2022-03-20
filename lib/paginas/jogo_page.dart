import 'package:batalha_naval/app_colors.dart';
import 'package:batalha_naval/base/base_view.dart';
import 'package:batalha_naval/componentes/common/batalha_dialog.dart';
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
      onInitState: (viewModel) {
        viewModel.initCommand(tabuleiroNavios);
      },
      builder: (context, viewModel) {
        return Scaffold(
          backgroundColor: PrimaryColor,
          body: Row(
            children: [
              this._sideBar(context, viewModel),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Seu tabuleiro",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    BatalhaBoard(
                      x: tabuleiroNavios.limiteHorizontal,
                      y: tabuleiroNavios.limiteVertical,
                      tilesInfo: viewModel.infos(),
                      onTapItem: (coordenada) {
                        return showBatalhaDialog(
                          context,
                          "Informamos:",
                          "Este é seu tabuleiro, você não pode realizar ações aqui. A cada turno a máquina irá realizar suas ações e este tabuleiro será atualizado.",
                          () {
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Tabuleiro Maquina",
                      style: TextStyle(
                        color: TextColor,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    BatalhaBoard(
                      x: tabuleiroNavios.limiteHorizontal,
                      y: tabuleiroNavios.limiteVertical,
                      //tilesInfo: viewModel.infos(),
                      onTapItem: (coordenada) {
                        //viewModel.adicionarNavioCommand(coordenada);
                      },
                    ),
                  ],
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
                "Submarinos abatidos: 0",
                style: TextStyle(
                  color: TextColor,
                ),
              ),
              Text(
                "Contratorpedeiros abatidos: 0",
                style: TextStyle(
                  color: TextColor,
                ),
              ),
              Text(
                "Navios Tanque abatidos: 0",
                style: TextStyle(
                  color: TextColor,
                ),
              ),
              Text(
                "Porta Aviões abatidos: 0",
                style: TextStyle(
                  color: TextColor,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Tiros utilizados: 0",
                style: TextStyle(
                  color: TextColor,
                ),
              ),
              Text(
                "Tiros especiais utilizados: 0",
                style: TextStyle(
                  color: TextColor,
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: 200.0,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: 200.0,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
