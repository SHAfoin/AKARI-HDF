// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GrilleAdapter extends TypeAdapter<Grille> {
  @override
  final int typeId = 7;

  @override
  Grille read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Grille()
      ..length = fields[0] as int
      .._matrice = (fields[1] as List)
          .map((dynamic e) => (e as List).cast<Cases>())
          .toList()
      .._candidats = (fields[2] as List)
          .map((dynamic e) => (e as List).cast<bool>())
          .toList();
  }

  @override
  void write(BinaryWriter writer, Grille obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.length)
      ..writeByte(1)
      ..write(obj._matrice)
      ..writeByte(2)
      ..write(obj._candidats);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GrilleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CasesAdapter extends TypeAdapter<Cases> {
  @override
  final int typeId = 8;

  @override
  Cases read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Cases.nonEclaire;
      case 1:
        return Cases.eclaire;
      case 2:
        return Cases.ampoule;
      case 3:
        return Cases.mur;
      case 4:
        return Cases.ampouleRouge;
      case 5:
        return Cases.zeroCell;
      case 6:
        return Cases.oneCell;
      case 7:
        return Cases.twoCell;
      case 8:
        return Cases.threeCell;
      case 9:
        return Cases.fourCell;
      case 10:
        return Cases.point;
      case 11:
        return Cases.pointEclaire;
      case 12:
        return Cases.zeroCellWrong;
      case 13:
        return Cases.oneCellWrong;
      case 14:
        return Cases.twoCellWrong;
      case 15:
        return Cases.threeCellWrong;
      case 16:
        return Cases.fourCellWrong;
      case 17:
        return Cases.other;
      default:
        return Cases.nonEclaire;
    }
  }

  @override
  void write(BinaryWriter writer, Cases obj) {
    switch (obj) {
      case Cases.nonEclaire:
        writer.writeByte(0);
        break;
      case Cases.eclaire:
        writer.writeByte(1);
        break;
      case Cases.ampoule:
        writer.writeByte(2);
        break;
      case Cases.mur:
        writer.writeByte(3);
        break;
      case Cases.ampouleRouge:
        writer.writeByte(4);
        break;
      case Cases.zeroCell:
        writer.writeByte(5);
        break;
      case Cases.oneCell:
        writer.writeByte(6);
        break;
      case Cases.twoCell:
        writer.writeByte(7);
        break;
      case Cases.threeCell:
        writer.writeByte(8);
        break;
      case Cases.fourCell:
        writer.writeByte(9);
        break;
      case Cases.point:
        writer.writeByte(10);
        break;
      case Cases.pointEclaire:
        writer.writeByte(11);
        break;
      case Cases.zeroCellWrong:
        writer.writeByte(12);
        break;
      case Cases.oneCellWrong:
        writer.writeByte(13);
        break;
      case Cases.twoCellWrong:
        writer.writeByte(14);
        break;
      case Cases.threeCellWrong:
        writer.writeByte(15);
        break;
      case Cases.fourCellWrong:
        writer.writeByte(16);
        break;
      case Cases.other:
        writer.writeByte(17);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CasesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
