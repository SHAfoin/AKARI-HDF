import 'package:akari_project/page_shop/shop_item.dart';
import 'package:hive/hive.dart';

Future<void> initShopDatabase() async {


  var box = Hive.box('shopItemBox');

  List<ShopItem> items = [
    ShopItem(
        name: "Jaune/Rouge",
        price: 50,
        isBought: true,
        pathToImage: "assets/images/shop_items/background_red.png",
        type: ShopItemType.background),
    ShopItem(
        name: "Vert",
        price: 50,
        isBought: false,
        pathToImage: "assets/images/shop_items/background_green.png",
        type: ShopItemType.background),
    ShopItem(
        name: "Bleu",
        price: 50,
        isBought: false,
        pathToImage: "assets/images/shop_items/background_blue.png",
        type: ShopItemType.background),
    ShopItem(
        name: "Minecraft",
        price: 500,
        isBought: false,
        pathToImage: "assets/images/shop_items/background_minecraft.png",
        type: ShopItemType.background),
    ShopItem(
        name: "Steampunk",
        price: 300,
        isBought: false,
        pathToImage: "assets/images/shop_items/background_steampunk.jpg",
        type: ShopItemType.background),
    ShopItem(
        name: "Sakura",
        price: 300,
        isBought: false,
        pathToImage: "assets/images/shop_items/background_sakura.jpg",
        type: ShopItemType.background),

    ShopItem(
        name: "Jaune",
        price: 50,
        isBought: true,
        pathToImage: "assets/images/shop_items/bulb_yellow.png",
        type: ShopItemType.bulb),
    ShopItem(
        name: "Bleu",
        price: 50,
        isBought: false,
        pathToImage: "assets/images/shop_items/bulb_blue.png",
        type: ShopItemType.bulb),
    ShopItem(
        name: "Vert",
        price: 50,
        isBought: false,
        pathToImage: "assets/images/shop_items/bulb_green.png",
        type: ShopItemType.bulb),
    ShopItem(
        name: "Torche",
        price: 200,
        isBought: false,
        pathToImage: "assets/images/shop_items/bulb_minecraft.png",
        type: ShopItemType.bulb),
    ShopItem(
        name: "Lampion",
        price: 200,
        isBought: false,
        pathToImage: "assets/images/shop_items/bulb_japanese.png",
        type: ShopItemType.bulb),
    ShopItem(
        name: "Steampunk",
        price: 200,
        isBought: false,
        pathToImage: "assets/images/shop_items/bulb_steampunk.png",
        type: ShopItemType.bulb),
  ];

  for (var i = 0; i < items.length; i++) {
    box.put(i, items[i]);
  }

  print(box.values);
  
}