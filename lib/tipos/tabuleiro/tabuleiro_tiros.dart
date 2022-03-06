import 'package:batalha_naval/tipos/tiros/tiro.dart';

class TabuleiroTiros {
  late int limiteVertical;
  late int limiteHorizontal;
  late List<Tiro> navios;

  TabuleiroTiros({
    required this.limiteHorizontal,
    required this.limiteVertical,
    List<Tiro>? navios,
  }) : this.navios = navios ?? [];
}
