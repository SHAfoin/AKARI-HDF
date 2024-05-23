import 'package:hive/hive.dart';
part 'shop_item.g.dart';


@HiveType(typeId: 2)
enum ShopItemType {
  @HiveField(0)
  background,

  @HiveField(1)
  bulb

}


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