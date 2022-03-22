import 'dart:async';

import 'package:batalha_naval/app_colors.dart';
import 'package:batalha_naval/base/base_view_model.dart';
import 'package:batalha_naval/entidades/maquina.dart';
import 'package:batalha_naval/tipos/board_tile_info.dart';
import 'package:batalha_naval/tipos/coordenada.dart';
import 'package:batalha_naval/tipos/tabuleiro/navio_tabuleiro.dart';
import 'package:batalha_naval/tipos/tabuleiro/tabuleiro_navios.dart';
import 'package:batalha_naval/tipos/tabuleiro/tabuleiro_tiros.dart';
import 'package:batalha_naval/tipos/tabuleiro/tiro_tabuleiro.dart';
import 'package:batalha_naval/tipos/tiros/tiro_especial.dart';
import 'package:batalha_naval/tipos/tiros/tiro_normal.dart';
import 'package:injectable/injectable.dart';
import 'package:rx_command/rx_command.dart';

enum GameStatus {
  TiroEspeciaisIndisponiveis,
  EspacoOcupado,
  JogadorVenceu,
  MaquinaVenceu,
}

@injectable
class JogoViewModel extends BaseViewModel {
  int quantidadeDeTirosNormais = 0;
  int quantidadeDeTirosEspeciaisRestantes = 2;

  int submarinosAbatidos = 0;
  int contratorpedeirosAbatidos = 0;
  int naviosTanqueAbatidos = 0;
  int portaAvioesAbatidos = 0;

  int submarinosAbatidosMaquina = 0;
  int contratorpedeirosAbatidosMaquina = 0;
  int naviosTanqueAbatidosMaquina = 0;
  int portaAvioesAbatidosMaquina = 0;

  int _tirosNormaisRealizados = 0;
  int _tirosEspecaisRealizados = 0;
  List<TiroTabuleiro> _tiros = [];

  List<String> tiposDeTiro = ["Normal", "Especial"];
  String tipoDeTiroSelecionado = "Normal";

  late TabuleiroNavios _tabuleiroNavios = TabuleiroNavios(limiteHorizontal: 0, limiteVertical: 0);
  TabuleiroNavios get tabuleiroNavios => this._tabuleiroNavios;
  List<NavioTabuleiro> get navios => this._tabuleiroNavios.navios;

  late TabuleiroTiros _tabuleiroTiros = TabuleiroTiros(limiteHorizontal: 0, limiteVertical: 0);
  TabuleiroTiros get tabuleiroTiros => this._tabuleiroTiros;
  List<TiroTabuleiro> get tiros => this._tabuleiroTiros.tiros;

  late TabuleiroNavios _tabuleiroNaviosMaquina;
  late TabuleiroTiros _tabuleiroTirosMaquina;
  late Maquina _maquina = Maquina();

  late RxCommand<TabuleiroNavios, void> _initCommand;
  RxCommand<TabuleiroNavios, void> get initCommand => this._initCommand;

  late RxCommand<String, void> _alterarTipoTiroCommand;
  RxCommand<String, void> get alterarTipoTiroCommand => this._alterarTipoTiroCommand;

  late RxCommand<Coordenada, bool> _adicionarTiroCommand;
  RxCommand<Coordenada, bool> get adicionarTiroCommand => this._adicionarTiroCommand;

  StreamController<GameStatus> _gameEvents = StreamController<GameStatus>.broadcast();
  Stream<GameStatus> get gameEvents => this._gameEvents.stream;

  JogoViewModel() {
    this._initCommand = RxCommand.createSyncNoResult(this._onInit);
    this._alterarTipoTiroCommand = RxCommand.createSyncNoResult(this._onAlterarTipoTiro);
    this._adicionarTiroCommand = RxCommand.createSync(this._onAdicionarTiro);
  }

  void _onInit(TabuleiroNavios tabuleiro) {
    this._tabuleiroNavios = tabuleiro;
    this._tabuleiroTiros = TabuleiroTiros(
      limiteHorizontal: tabuleiroNavios.limiteHorizontal,
      limiteVertical: tabuleiroNavios.limiteVertical,
    );

    this._tabuleiroNaviosMaquina =
        this._maquina.geraTabuleiroMaquina(tabuleiro.limiteHorizontal, tabuleiro.limiteVertical);

    this._tabuleiroTirosMaquina = this
        ._maquina
        .geraTabuleiroTiroMaquina(this._tabuleiroNavios.limiteHorizontal, this._tabuleiroNavios.limiteVertical);
  }

  void _onAlterarTipoTiro(String tiro) {
    this.tipoDeTiroSelecionado = tiro;
  }

  bool _onAdicionarTiro(Coordenada coordenada) {
    final TiroTabuleiro tiroTabuleiro = this._getTiro(coordenada);

    final tabuleiroDeBatalha = this
        ._tabuleiroNavios
        .mesclarTabuleiroDeNaviosComTiros(this._tabuleiroNavios, this._tabuleiroTirosMaquina.gerarTabuleiro());

    if (tiroTabuleiro.tiro is TiroNormal && this._tirosNormaisRealizados < 3 && this._tirosEspecaisRealizados == 0) {
      if (this._tabuleiroTiros.existeLocalExplodido(tiroTabuleiro)) {
        this._gameEvents.add(GameStatus.EspacoOcupado);
        return false;
      }

      this._tiros.add(tiroTabuleiro);
      this.quantidadeDeTirosNormais++;
      this._tirosNormaisRealizados++;

      if (_tirosNormaisRealizados == 3) {
        this._tabuleiroTiros.inserirTiro(_tiros[0]);
        this._tabuleiroTiros.inserirTiro(_tiros[1]);
        this._tabuleiroTiros.inserirTiro(_tiros[2]);
        this._tiros = [];
        this._tirosNormaisRealizados = 0;

        this._maquina.tirosAutomaticos(this._tabuleiroTirosMaquina, tabuleiroDeBatalha);
        return true;
      }
    }

    if (tiroTabuleiro.tiro is TiroEspecial &&
        this._tirosEspecaisRealizados == 0 &&
        this._tirosNormaisRealizados == 0 &&
        this.quantidadeDeTirosEspeciaisRestantes > 0) {
      this._tiros.add(tiroTabuleiro);
      this._tirosEspecaisRealizados++;
      this.quantidadeDeTirosEspeciaisRestantes--;

      if (this._tirosEspecaisRealizados == 1) {
        this._tabuleiroTiros.inserirTiro(_tiros[0]);
        this._tiros = [];
        this._tirosEspecaisRealizados = 0;

        this._maquina.tirosAutomaticos(this._tabuleiroTirosMaquina, tabuleiroDeBatalha);
        return true;
      }
    }

    if (tiroTabuleiro.tiro is TiroEspecial && this.quantidadeDeTirosEspeciaisRestantes == 0) {
      this._gameEvents.add(GameStatus.TiroEspeciaisIndisponiveis);
    }

    return true;
  }

  List<BoardTileInfo> informacoesVisuaisMeuTabuleiro() {
    final tabuleiroDeBatalha = this
        ._tabuleiroNavios
        .mesclarTabuleiroDeNaviosComTiros(this._tabuleiroNavios, this._tabuleiroTirosMaquina.gerarTabuleiro());

    setStateToReady();
    final informacoesVisuais = this._extrairDadosPelaMatriz(tabuleiroDeBatalha, true);

    if (this.usuarioVenceuOJogo()) {
      this._gameEvents.add(GameStatus.MaquinaVenceu);
    }

    return informacoesVisuais;
  }

  List<BoardTileInfo> informacoesVisuaisTabuleiroMaquina() {
    final tabuleiroTirosUsuario = this._tabuleiroTiros.gerarTabuleiro();
    final tabuleiroDeBatalha = this
        ._tabuleiroNaviosMaquina
        .mesclarTabuleiroDeNaviosComTiros(this._tabuleiroNaviosMaquina, tabuleiroTirosUsuario);

    setStateToReady();

    final informacoesVisuais = this._extrairDadosPelaMatriz(tabuleiroDeBatalha, false);

    if (this.usuarioVenceuOJogo()) {
      this._gameEvents.add(GameStatus.JogadorVenceu);
    }

    return informacoesVisuais;
  }

  bool usuarioVenceuOJogo() {
    return submarinosAbatidos == 4 &&
        contratorpedeirosAbatidos == 3 &&
        naviosTanqueAbatidos == 2 &&
        portaAvioesAbatidos == 1;
  }

  bool maquinaVenceuOJogo() {
    return submarinosAbatidosMaquina == 4 &&
        contratorpedeirosAbatidosMaquina == 3 &&
        naviosTanqueAbatidosMaquina == 2 &&
        portaAvioesAbatidosMaquina == 1;
  }

  TiroTabuleiro _getTiro(Coordenada coordenada) {
    switch (this.tipoDeTiroSelecionado) {
      case "Normal":
        return TiroTabuleiro(
          x: coordenada.x,
          y: coordenada.y,
          tiro: TiroNormal(),
        );
      case "Especial":
        return TiroTabuleiro(
          x: coordenada.x,
          y: coordenada.y,
          tiro: TiroEspecial(),
        );
      default:
        return TiroTabuleiro(
          x: coordenada.x,
          y: coordenada.y,
          tiro: TiroNormal(),
        );
    }
  }

  List<BoardTileInfo> _extrairDadosPelaMatriz(List<List<String>> matriz, bool ehMaquina) {
    List<BoardTileInfo> informacoeesVisuais = [];

    int contadorS = 0;
    int contadorC = 0;
    int contadorT = 0;
    int contadorP = 0;

    for (int i = 0; i < matriz.length; i++) {
      for (int j = 0; j < matriz[i].length; j++) {
        switch (matriz[i][j]) {
          case 'S':
            contadorS++;
            informacoeesVisuais.add(BoardTileInfo(coordenada: Coordenada(x: i, y: j), color: SubmarinoColor));
            break;
          case 'C':
            contadorC++;
            informacoeesVisuais.add(BoardTileInfo(coordenada: Coordenada(x: i, y: j), color: ContratorpedeiroColor));
            break;
          case 'T':
            contadorT++;
            informacoeesVisuais.add(BoardTileInfo(coordenada: Coordenada(x: i, y: j), color: NavioTanqueColor));
            break;
          case 'P':
            contadorP++;
            informacoeesVisuais.add(BoardTileInfo(coordenada: Coordenada(x: i, y: j), color: PortaAviaoColor));
            break;
          case 'V':
            informacoeesVisuais.add(BoardTileInfo(coordenada: Coordenada(x: i, y: j), color: NavioAtingidoColor));
            break;
          case 'X':
            informacoeesVisuais.add(BoardTileInfo(coordenada: Coordenada(x: i, y: j), color: TiroColor));
            break;
        }
      }
    }

    if (!ehMaquina) {
      this.submarinosAbatidos = contadorS ~/ 2;
      this.portaAvioesAbatidos = contadorP ~/ 5;
      this.naviosTanqueAbatidos = contadorT ~/ 4;
      this.contratorpedeirosAbatidos = contadorC ~/ 3;
    } else {
      this.submarinosAbatidosMaquina = contadorS ~/ 2;
      this.portaAvioesAbatidosMaquina = contadorP ~/ 5;
      this.naviosTanqueAbatidosMaquina = contadorT ~/ 4;
      this.contratorpedeirosAbatidosMaquina = contadorC ~/ 3;

      print(submarinosAbatidosMaquina);
      print(portaAvioesAbatidosMaquina);
      print(naviosTanqueAbatidosMaquina);
      print(contratorpedeirosAbatidosMaquina);
    }

    return informacoeesVisuais;
  }
}
