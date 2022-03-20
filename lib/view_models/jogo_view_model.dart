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

@injectable
class JogoViewModel extends BaseViewModel {
  int quantidadeDeTirosNormais = 0;
  int quantidadeDeTirosEspeciaisRestantes = 2;
  int submarinosAbatidos = 0;
  int contratorpedeirosAbatidos = 0;
  int naviosTanqueAbatidos = 0;
  int portaAvioesAbatidos = 0;

  List<String> tiposDeTiro = ["Normal", "Especial"];
  String tipoDeTiroSelecionado = "Normal";

  late TabuleiroNavios _tabuleiroNavios = TabuleiroNavios(limiteHorizontal: 0, limiteVertical: 0);
  TabuleiroNavios get tabuleiroNavios => this._tabuleiroNavios;
  List<NavioTabuleiro> get navios => this._tabuleiroNavios.navios;

  late TabuleiroTiros _tabuleiroTiros = TabuleiroTiros(limiteHorizontal: 0, limiteVertical: 0);
  TabuleiroTiros get tabuleiroTiros => this._tabuleiroTiros;
  List<TiroTabuleiro> get tiros => this._tabuleiroTiros.tiros;

  late TabuleiroNavios _tabuleiroNaviosMaquina;
  late Maquina _maquina = Maquina();

  late RxCommand<TabuleiroNavios, void> _initCommand;
  RxCommand<TabuleiroNavios, void> get initCommand => this._initCommand;

  late RxCommand<String, void> _alterarTipoTiroCommand;
  RxCommand<String, void> get alterarTipoTiroCommand => this._alterarTipoTiroCommand;

  late RxCommand<Coordenada, bool> _adicionarTiroCommand;
  RxCommand<Coordenada, bool> get adicionarTiroCommand => this._adicionarTiroCommand;

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
  }

  void _onAlterarTipoTiro(String tiro) {
    this.tipoDeTiroSelecionado = tiro;
  }

  bool _onAdicionarTiro(Coordenada coordenada) {
    final TiroTabuleiro tiroTabuleiro = this._getTiro(coordenada);

    if (tiroTabuleiro.tiro is TiroEspecial && this.quantidadeDeTirosEspeciaisRestantes > 0) {
      this._tabuleiroTiros.inserirTiro(tiroTabuleiro);

      this.quantidadeDeTirosEspeciaisRestantes = this.quantidadeDeTirosEspeciaisRestantes - 1;
      return true;
    }

    if (tiroTabuleiro.tiro is TiroEspecial && this.quantidadeDeTirosEspeciaisRestantes == 0) {
      return false;
    }

    final inserido = this._tabuleiroTiros.inserirTiro(tiroTabuleiro);
    if (inserido) {
      this.quantidadeDeTirosNormais++;
      return true;
    }

    return false;
  }

  List<BoardTileInfo> informacoesVisuaisMeuTabuleiro() {
    //final matrizTabuleiroNavios = this._tabuleiroNaviosMaquina.gerarTabuleiro();
    //final teste =

    // var tabuleiroDeBatalha =
    //         tabuleiroMaquina.gerarTabuleiroComTiros(tabuleiroMaquina, tabuleiroTiro.gerarTabuleiro());

    //final tabuleiroNavioUsuario = this._tabuleiroNavios.gerarTabuleiro();
    // final
    // final tabuleiroDeBatalha = this._tabuleiroNavios.gerarTabuleiroComTiros(this._tabuleiroNavios, tiros)

    // final matrizTabuleiroNavios = this._tabuleiroNaviosMaquina.gerarTabuleiroComTiros(
    //       tabuleiroNavios,
    //     );

    //MatrizHelper().imprimirMatriz(matrizTabuleiroNavios);

    final List<BoardTileInfo> _infos = [];

    this.navios.forEach((navio) {
      final informacoes = navio.pontos
          .map((ponto) => BoardTileInfo(coordenada: Coordenada(x: ponto.x, y: ponto.y), color: navio.navio.color));
      _infos.addAll(informacoes);
    });

    setStateToReady();
    return _infos;
  }

  List<BoardTileInfo> informacoesVisuaisTabuleiroMaquina() {
    final tabuleiroTirosUsuario = this._tabuleiroTiros.gerarTabuleiro();
    final tabuleiroDeTabalha = this
        ._tabuleiroNaviosMaquina
        .mesclarTabuleiroDeNaviosComTiros(this._tabuleiroNaviosMaquina, tabuleiroTirosUsuario);

    setStateToReady();
    return this._extrairDadosPelaMatriz(tabuleiroDeTabalha);
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

  List<BoardTileInfo> _extrairDadosPelaMatriz(List<List<String>> matriz) {
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

    this.submarinosAbatidos = contadorS ~/ 2;
    this.portaAvioesAbatidos = contadorP ~/ 5;
    this.naviosTanqueAbatidos = contadorT ~/ 4;
    this.contratorpedeirosAbatidos = contadorC ~/ 3;

    return informacoeesVisuais;
  }
}
