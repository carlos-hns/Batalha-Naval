import 'package:batalha_naval/base/base_view_model.dart';
import 'package:batalha_naval/tipos/board_tile_info.dart';
import 'package:batalha_naval/tipos/configuration_step.dart';
import 'package:batalha_naval/tipos/coordenada.dart';
import 'package:batalha_naval/tipos/eixo.dart';
import 'package:batalha_naval/tipos/navios/contra_torpedeiro.dart';
import 'package:batalha_naval/tipos/navios/navio_tanque.dart';
import 'package:batalha_naval/tipos/navios/porta_aviao.dart';
import 'package:batalha_naval/tipos/navios/submarino.dart';
import 'package:batalha_naval/tipos/tabuleiro/navio_tabuleiro.dart';
import 'package:batalha_naval/tipos/tabuleiro/tabuleiro_navios.dart';
import 'package:batalha_naval/tipos/tamanho.dart';
import 'package:injectable/injectable.dart';
import 'package:rx_command/rx_command.dart';

@injectable
class InsercaoNaviosViewModel extends BaseViewModel {
  ConfigurationStep configurationStep = ConfigurationStep.Tamanho;

  List<String> tamanhosDeTabuleiro = ["10x10", "15x15"];
  String tamanhoAtualTabuleiro = "10x10";

  List<String> tiposDeNavio = ["Submarino", "Contratorpedeiro", "Navio Tanque", "Porta Avião"];
  String tipoDeNavioSelecionado = "Submarino";

  List<String> eixos = ["Horizontal", "Vertical"];
  String eixoSelecionado = "Horizontal";

  late TabuleiroNavios _tabuleiroNavios = TabuleiroNavios(limiteHorizontal: 0, limiteVertical: 0);
  List<NavioTabuleiro> get navios => this._tabuleiroNavios.navios;

  late RxCommand<String, Tamanho> _alterarTamanhoDoTabuleiroCommand;
  RxCommand<String, Tamanho> get alterarTamanhoDoTabuleiroCommand => this._alterarTamanhoDoTabuleiroCommand;

  late RxCommand<String, void> _alterarTipoNavioCommand;
  RxCommand<String, void> get alterarTipoNavioCommand => this._alterarTipoNavioCommand;

  late RxCommand<String, void> _alterarEixoCommand;
  RxCommand<String, void> get alterarEixoCommand => this._alterarEixoCommand;

  late RxCommand<ConfigurationStep, void> _alterarStepCommand;
  RxCommand<ConfigurationStep, void> get alterarStepCommand => this._alterarStepCommand;

  late RxCommand<Coordenada, bool> _adicionarNavioCommand;
  RxCommand<Coordenada, bool> get adicionarNavioCommand => this._adicionarNavioCommand;

  InsercaoNaviosViewModel() {
    this._alterarTamanhoDoTabuleiroCommand = RxCommand.createSync(this._onAlterarTamanhoDoTabuleiro);
    this._alterarTipoNavioCommand = RxCommand.createSyncNoResult(this._onAlterarTipoNavio);
    this._alterarEixoCommand = RxCommand.createSyncNoResult(this._onAlterarEixo);
    this._alterarStepCommand = RxCommand.createSyncNoResult(this._onAlterarStep);
    this._adicionarNavioCommand = RxCommand.createSync(this._onAdicionarNavio);
  }

  Tamanho _onAlterarTamanhoDoTabuleiro(String tamanho) {
    this.tamanhoAtualTabuleiro = tamanho;
    return _transformarTamanho(tamanho);
  }

  void _onAlterarTipoNavio(String tipoNavio) {
    this.tipoDeNavioSelecionado = tipoNavio;
  }

  void _onAlterarEixo(String eixoSelecionado) {
    this.eixoSelecionado = eixoSelecionado;
  }

  void _onAlterarStep(ConfigurationStep step) {
    final tamanhoAtual = _transformarTamanho(this.tamanhoAtualTabuleiro);
    this._tabuleiroNavios = TabuleiroNavios(limiteHorizontal: tamanhoAtual.x, limiteVertical: tamanhoAtual.y);

    this.configurationStep = step;
    this.setStateToReady();
  }

  bool _onAdicionarNavio(Coordenada coordenada) {
    final navio = this._getNavio(coordenada);
    final adicionado = this._tabuleiroNavios.inserirNavio(navio);
    this.setStateToReady();
    return adicionado;
  }

  Tamanho _transformarTamanho(String tamanho) {
    final splitedNumbers = tamanho.split("x");
    return Tamanho(int.parse(splitedNumbers[0]), int.parse(splitedNumbers[1]));
  }

  Eixo _getEixoFromString(String eixo) {
    return eixo == "Horizontal" ? Eixo.Horizontal : Eixo.Vertical;
  }

  NavioTabuleiro _getNavio(Coordenada coordenada) {
    switch (this.tipoDeNavioSelecionado) {
      case "Submarino":
        return NavioTabuleiro(
          x: coordenada.x,
          y: coordenada.y,
          eixo: this._getEixoFromString(this.eixoSelecionado),
          navio: Submarino(),
        );
      case "Navio Tanque":
        return NavioTabuleiro(
          x: coordenada.x,
          y: coordenada.y,
          eixo: this._getEixoFromString(this.eixoSelecionado),
          navio: NavioTanque(),
        );
      case "Porta Avião":
        return NavioTabuleiro(
          x: coordenada.x,
          y: coordenada.y,
          eixo: this._getEixoFromString(this.eixoSelecionado),
          navio: PortaAviao(),
        );
      case "Contratorpedeiro":
        return NavioTabuleiro(
          x: coordenada.x,
          y: coordenada.y,
          eixo: this._getEixoFromString(this.eixoSelecionado),
          navio: ContraTorpedeiro(),
        );
      default:
        return NavioTabuleiro(
          x: coordenada.x,
          y: coordenada.y,
          eixo: this._getEixoFromString(this.eixoSelecionado),
          navio: Submarino(),
        );
    }
  }

  List<BoardTileInfo> infos() {
    final List<BoardTileInfo> _infos = [];

    this.navios.forEach((navio) {
      final informacoes = navio.pontos
          .map((ponto) => BoardTileInfo(coordenada: Coordenada(x: ponto.x, y: ponto.y), color: navio.navio.color));
      _infos.addAll(informacoes);
    });

    return _infos;
  }
}
