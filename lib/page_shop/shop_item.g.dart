// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShopItemAdapter extends TypeAdapter<ShopItem> {
  @override
  final int typeId = 0;

  @override
  ShopItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ShopItem(
      name: fields[0] as String,
      price: fields[1] as int,
      pathToImage: fields[2] as String,
      isBought: fields[3] as bool,
      type: fields[4] as ShopItemType,
    );
  }

  @override
  void write(BinaryWriter writer, ShopItem obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.price)
      ..writeByte(2)
      ..write(obj.pathToImage)
      ..writeByte(3)
      ..write(obj.isBought)
      ..writeByte(4)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShopItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ShopItemTypeAdapter extends TypeAdapter<ShopItemType> {
  @override
  final int typeId = 2;

  @override
  ShopItemType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ShopItemType.background;
      case 1:
        return ShopItemType.bulb;
      default:
        return ShopItemType.background;
    }
  }

  @override
  void write(BinaryWriter writer, ShopItemType obj) {
    switch (obj) {
      case ShopItemType.background:
        writer.writeByte(0);
        break;
      case ShopItemType.bulb:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShopItemTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
