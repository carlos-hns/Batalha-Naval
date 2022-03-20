import 'package:batalha_naval/base/base_view.dart';
import 'package:batalha_naval/componentes/common/batalha_dialog.dart';
import 'package:batalha_naval/componentes/tabuleiro/batalha_board.dart';
import 'package:batalha_naval/componentes/common/batalha_botao.dart';
import 'package:batalha_naval/componentes/configuracoes/configuration_element.dart';
import 'package:batalha_naval/tipos/configuration_step.dart';
import 'package:batalha_naval/tipos/tamanho.dart';
import 'package:batalha_naval/view_models/insercao_navios_view_model.dart';
import 'package:flutter/material.dart';
import 'package:rx_widgets/rx_widgets.dart';

class InsercaoNaviosPage extends StatelessWidget {
  const InsercaoNaviosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<InsercaoNaviosViewModel>(
      onInitState: (viewModel) {
        viewModel.adicionarNavioCommand.results
            .where((event) => event.data != null)
            .map((result) => result.data)
            .listen((foiAdicionado) {
          if (!(foiAdicionado!)) {
            return showBatalhaDialog(
              context,
              "Erro!",
              "Impossível adicionar návio (Insira dentro dos limites ou em um local sem conflito)",
              () {
                Navigator.pop(context);
              },
            );
          }
        });
      },
      builder: (context, viewModel) {
        return Scaffold(
          body: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              this._sideBar(context, viewModel),
              this._board(viewModel),
            ],
          ),
        );
      },
    );
  }

  Widget _sideBar(BuildContext context, InsercaoNaviosViewModel viewModel) {
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
              Visibility(
                visible: viewModel.configurationStep == ConfigurationStep.Tamanho,
                child: ConfigurationElement(
                  label: "Tamanho do tabuleiro",
                  options: viewModel.tamanhosDeTabuleiro,
                  current: viewModel.tamanhoAtualTabuleiro,
                  onChange: (novoTamanho) {
                    viewModel.alterarTamanhoDoTabuleiroCommand(novoTamanho);
                  },
                ),
              ),
              Visibility(
                visible: viewModel.configurationStep == ConfigurationStep.Insercao,
                child: ConfigurationElement(
                  label: "Tipo de Navio",
                  options: viewModel.tiposDeNavio,
                  current: viewModel.tipoDeNavioSelecionado,
                  onChange: (novoTipoNavio) {
                    viewModel.alterarTipoNavioCommand(novoTipoNavio);
                  },
                ),
              ),
              Visibility(
                visible: viewModel.configurationStep == ConfigurationStep.Insercao,
                child: ConfigurationElement(
                  label: "Eixo",
                  options: viewModel.eixos,
                  current: viewModel.eixoSelecionado,
                  onChange: (novoEixo) {
                    viewModel.alterarEixoCommand(novoEixo);
                  },
                ),
              ),
              Visibility(
                visible: viewModel.configurationStep == ConfigurationStep.Tamanho,
                child: BatalhaBotao(
                  label: "Iniciar Inserção",
                  onTap: () => viewModel.alterarStepCommand(ConfigurationStep.Insercao),
                ),
              ),
              Visibility(
                visible: viewModel.configurationStep == ConfigurationStep.Insercao,
                child: Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: BatalhaBotao(
                    label: "Resetar",
                    onTap: () => viewModel.alterarStepCommand(ConfigurationStep.Insercao),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _board(InsercaoNaviosViewModel viewModel) {
    return ReactiveBuilder<Tamanho>(
      initialData: Tamanho(10, 10),
      stream: viewModel.alterarTamanhoDoTabuleiroCommand.results.map((result) => result.data!),
      builder: (context, Tamanho tamanho) {
        return ReactiveBuilder(
          stream: viewModel.isBusy,
          builder: (context, _) {
            return Visibility(
              visible: viewModel.configurationStep == ConfigurationStep.Insercao,
              child: Expanded(
                child: BatalhaBoard(
                  x: tamanho.x,
                  y: tamanho.y,
                  tilesInfo: viewModel.infos(),
                  onTapItem: (coordenada) {
                    viewModel.adicionarNavioCommand(coordenada);
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
