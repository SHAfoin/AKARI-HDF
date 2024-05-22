enum ShopItemType {background, bulb}

class ShopItem {
  String name;
  int price;
  String pathToImage;
  bool isBought;
  ShopItemType type;

  ShopItem({required this.name, required this.price, required this.pathToImage, required this.isBought, required this.type});
}