import 'package:batalha_naval/componentes/tabuleiro/board_tile.dart';
import 'package:batalha_naval/tipos/board_tile_info.dart';
import 'package:batalha_naval/tipos/coordenada.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class BatalhaBoard extends StatelessWidget {
  int x;
  int y;
  List<BoardTileInfo>? tilesInfo;
  Function(Coordenada coordenada) onTapItem;

  BatalhaBoard({
    required this.x,
    required this.y,
    required this.onTapItem,
    List<BoardTileInfo>? tilesInfo,
    Key? key,
  })  : tilesInfo = tilesInfo ?? [],
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(x, (currentX) => this._createRow(currentX)),
    );
  }

  Row _createRow(int currentX) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        y,
        (currentY) {
          final info =
              this.tilesInfo!.firstWhereOrNull((info) => info.coordenada == Coordenada(x: currentX, y: currentY));

          return BoardTile(
            color: info != null ? info.color : null,
            onTap: () {
              this.onTapItem(Coordenada(x: currentX, y: currentY));
            },
          );
        },
      ),
    );
  }
}
