// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ranking.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RankingAdapter extends TypeAdapter<Ranking> {
  @override
  final int typeId = 1;

  @override
  Ranking read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Ranking()
      ..nome = fields[0] as String
      ..tamanhoTabuleiro = fields[1] as String
      ..numeroDeTirosNormais = fields[2] as int
      ..numeroDeTirosEspeciais = fields[3] as int;
  }

  @override
  void write(BinaryWriter writer, Ranking obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.nome)
      ..writeByte(1)
      ..write(obj.tamanhoTabuleiro)
      ..writeByte(2)
      ..write(obj.numeroDeTirosNormais)
      ..writeByte(3)
      ..write(obj.numeroDeTirosEspeciais);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RankingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
