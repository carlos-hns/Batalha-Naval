import 'package:batalha_naval/base/base_view_model.dart';
import 'package:batalha_naval/tipos/board_tile_info.dart';
import 'package:batalha_naval/tipos/coordenada.dart';
import 'package:batalha_naval/tipos/tabuleiro/navio_tabuleiro.dart';
import 'package:batalha_naval/tipos/tabuleiro/tabuleiro_navios.dart';
import 'package:injectable/injectable.dart';
import 'package:rx_command/rx_command.dart';

@injectable
class JogoViewModel extends BaseViewModel {
  late TabuleiroNavios _tabuleiroNavios = TabuleiroNavios(limiteHorizontal: 0, limiteVertical: 0);
  TabuleiroNavios get tabuleiro => this._tabuleiroNavios;
  List<NavioTabuleiro> get navios => this._tabuleiroNavios.navios;

  late RxCommand<TabuleiroNavios, void> _initCommand;
  RxCommand<TabuleiroNavios, void> get initCommand => this._initCommand;

  JogoViewModel() {
    this._initCommand = RxCommand.createSyncNoResult(this._onInit);
  }

  void _onInit(TabuleiroNavios tabuleiro) {
    this._tabuleiroNavios = tabuleiro;
  }

  List<BoardTileInfo> infos() {
    final List<BoardTileInfo> _infos = [];

    this.navios.forEach((navio) {
      final informacoes = navio.pontos
          .map((ponto) => BoardTileInfo(coordenada: Coordenada(x: ponto.x, y: ponto.y), color: navio.navio.color));
      _infos.addAll(informacoes);
    });

    setStateToReady();
    return _infos;
  }
}
