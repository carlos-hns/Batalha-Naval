import 'package:hive/hive.dart';

part 'ranking.g.dart';

@HiveType(typeId: 1)
class Ranking extends HiveObject {
  @HiveField(0)
  late String nome;

  @HiveField(1)
  late String tamanhoTabuleiro;

  @HiveField(2)
  late int numeroDeTiros;

  @HiveField(4)
  late String data;

  Ranking({
    required this.nome,
    required this.tamanhoTabuleiro,
    required this.numeroDeTiros,
    required this.data,
  });
}
