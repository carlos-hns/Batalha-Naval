import 'package:batalha_naval/app_colors.dart';
import 'package:batalha_naval/base/base_view.dart';
import 'package:batalha_naval/componentes/common/batalha_dialog.dart';
import 'package:batalha_naval/componentes/configuracoes/configuration_element.dart';
import 'package:batalha_naval/componentes/tabuleiro/batalha_board.dart';
import 'package:batalha_naval/paginas/menu_page.dart';
import 'package:batalha_naval/paginas/ranking_page.dart';
import 'package:batalha_naval/tipos/ranking.dart';
import 'package:batalha_naval/tipos/tabuleiro/tabuleiro_navios.dart';
import 'package:batalha_naval/view_models/jogo_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rx_widgets/rx_widgets.dart';

class JogoPage extends StatelessWidget {
  TabuleiroNavios tabuleiroNavios;

  JogoPage({
    required this.tabuleiroNavios,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BaseView<JogoViewModel>(
        onInitState: (viewModel) {
          viewModel.initCommand(tabuleiroNavios);

          viewModel.gameEvents.listen((event) {
            if (event == GameStatus.TiroEspeciaisIndisponiveis) {
              return showBatalhaDialog(
                context,
                "Erro!",
                "Você não possui tiros especiais restantes.",
                () {
                  Navigator.pop(context);
                },
              );
            }

            if (event == GameStatus.EspacoOcupado) {
              return showBatalhaDialog(
                context,
                "Erro!",
                "Você não pode adicionar um tiro em um local já atingido.",
                () {
                  Navigator.pop(context);
                },
              );
            }

            if (event == GameStatus.JogadorVenceu) {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  final rankingBox = Hive.box('ranking');

                  final ranking = Ranking(
                    nome: "Carlos",
                    tamanhoTabuleiro: "${tabuleiroNavios.limiteHorizontal}x${tabuleiroNavios.limiteVertical}",
                    numeroDeTiros:
                        viewModel.quantidadeDeTirosNormais + (2 - viewModel.quantidadeDeTirosEspeciaisRestantes),
                    data: DateTime.now().toString(),
                  );

                  rankingBox.add(ranking);

                  return RankingPage();
                },
              ));
            }

            if (event == GameStatus.MaquinaVenceu) {
              return showBatalhaDialog(context, "Erro!", "Você perdeu o jogo :'(", () {
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return MenuPage();
                  },
                ));
              });
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
                      ReactiveBuilder(
                        initialData: false,
                        stream: viewModel.adicionarTiroCommand.results.map((result) => result.data ?? false),
                        builder: (context, _) {
                          return BatalhaBoard(
                            x: tabuleiroNavios.limiteHorizontal,
                            y: tabuleiroNavios.limiteVertical,
                            tilesInfo: viewModel.informacoesVisuaisMeuTabuleiro(),
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
                          );
                        },
                      ),
                    ],
                  ),
                ),
                ReactiveBuilder(
                  initialData: false,
                  stream: viewModel.adicionarTiroCommand.results.map((result) => result.data ?? false),
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
                            tilesInfo: viewModel.informacoesVisuaisTabuleiroMaquina(),
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
      ),
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
                "Submarinos abatidos: ${viewModel.submarinosAbatidos}",
                style: TextStyle(
                  color: TextColor,
                  fontSize: 15.0,
                ),
              ),
              Text(
                "Contratorpedeiros abatidos: ${viewModel.contratorpedeirosAbatidos}",
                style: TextStyle(
                  color: TextColor,
                  fontSize: 15.0,
                ),
              ),
              Text(
                "Navios Tanque abatidos: ${viewModel.naviosTanqueAbatidos}",
                style: TextStyle(
                  color: TextColor,
                  fontSize: 15.0,
                ),
              ),
              Text(
                "Porta Aviões abatidos: ${viewModel.portaAvioesAbatidos}",
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
            ],
          );
        },
      ),
    );
  }
}
