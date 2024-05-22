import 'package:hive/hive.dart';
enum ShopItemType {background, bulb}

@HiveType(typeId: 0)
class ShopItem extends HiveObject{
  @HiveField(0)
  String name;
  @HiveField(1)
  int price;
  @HiveField(2)
  String pathToImage;
  @HiveField(3)
  bool isBought;
  @HiveField(4)
  ShopItemType type;

  ShopItem({required this.name, required this.price, required this.pathToImage, required this.isBought, required this.type});
}