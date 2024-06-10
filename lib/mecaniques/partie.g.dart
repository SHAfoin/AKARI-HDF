// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partie.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PartieAdapter extends TypeAdapter<Partie> {
  @override
  final int typeId = 6;

  @override
  Partie read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Partie()
      .._initial = fields[0] as Grille
      ..puzzle = fields[1] as Grille
      ..listeAction = (fields[2] as List).cast<Grille>()
      ..timer = fields[3] as int;
  }

  @override
  void write(BinaryWriter writer, Partie obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj._initial)
      ..writeByte(1)
      ..write(obj.puzzle)
      ..writeByte(2)
      ..write(obj.listeAction)
      ..writeByte(3)
      ..write(obj.timer);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PartieAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
