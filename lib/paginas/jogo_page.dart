import 'package:batalha_naval/app_colors.dart';
import 'package:batalha_naval/base/base_view.dart';
import 'package:batalha_naval/componentes/common/batalha_dialog.dart';
import 'package:batalha_naval/componentes/configuracoes/configuration_element.dart';
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
        // TODO: FECHAR STREAMS EM TODAS AS PAGINAS
        viewModel.initCommand(tabuleiroNavios);

        viewModel.adicionarTiroCommand.results
            .where((event) => event.data != null)
            .map((result) => result.data)
            .listen((adicionou) {
          if (!(adicionou!)) {
            return showBatalhaDialog(
              context,
              "Erro!",
              "Verifique se você tem tiros especiais disponíveis ou atirou em um local válido.",
              () {
                Navigator.pop(context);
              },
            );
          }
        });
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
                      tilesInfo: viewModel.infosNavios(),
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
              ReactiveBuilder(
                initialData: false,
                stream: viewModel.adicionarTiroCommand.results.map((result) => result.data!),
                builder: (context, _) {
                  return Expanded(
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
                          tilesInfo: viewModel.infosTiros(),
                          onTapItem: (coordenada) {
                            viewModel.adicionarTiroCommand(coordenada);
                          },
                        ),
                      ],
                    ),
                  );
                },
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
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: 50.0,
              ),
              Text(
                "Submarinos abatidos: 0",
                style: TextStyle(
                  color: TextColor,
                  fontSize: 15.0,
                ),
              ),
              Text(
                "Contratorpedeiros abatidos: 0",
                style: TextStyle(
                  color: TextColor,
                  fontSize: 15.0,
                ),
              ),
              Text(
                "Navios Tanque abatidos: 0",
                style: TextStyle(
                  color: TextColor,
                  fontSize: 15.0,
                ),
              ),
              Text(
                "Porta Aviões abatidos: 0",
                style: TextStyle(
                  color: TextColor,
                  fontSize: 15.0,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                "Tiros utilizados: ${viewModel.quantidadeDeTirosNormais}",
                style: TextStyle(
                  color: TextColor,
                  fontSize: 15.0,
                ),
              ),
              Text(
                "Tiros especiais disponíveis: ${viewModel.quantidadeDeTirosEspeciaisRestantes}",
                style: TextStyle(
                  color: TextColor,
                  fontSize: 15.0,
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Divider(
                color: Colors.white,
                height: 2.0,
              ),
              SizedBox(
                height: 15.0,
              ),
              ConfigurationElement(
                label: "Tipo do Tiro",
                options: viewModel.tiposDeTiro,
                current: viewModel.tipoDeTiroSelecionado,
                labelSize: 20.0,
                onChange: (novoTipoTiro) {
                  viewModel.alterarTipoTiroCommand(novoTipoTiro);
                  //viewModel.alterarTamanhoDoTabuleiroCommand(novoTamanho);
                },
              ),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SingleChildScrollView(
                          child: Container(
                            height: constraints.constrainHeight() * 0.9,
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
                            height: constraints.constrainHeight() * 0.9,
                            width: 200.0,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
