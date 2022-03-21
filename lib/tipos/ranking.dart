import 'package:hive/hive.dart';

part 'ranking.g.dart';

@HiveType(typeId: 1)
class Ranking extends HiveObject {
  @HiveField(0)
  late String nome;

  @HiveField(1)
  late String tamanhoTabuleiro;

  @HiveField(2)
  late int numeroDeTirosNormais;

  @HiveField(3)
  late int numeroDeTirosEspeciais;

  Ranking({
    required this.nome,
    required this.tamanhoTabuleiro,
    required this.numeroDeTirosNormais,
    required this.numeroDeTirosEspeciais,
  });
}
