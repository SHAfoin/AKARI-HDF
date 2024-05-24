import 'package:akari_project/general/user.dart';
import 'package:akari_project/page_shop/shop_item.dart';
import 'package:akari_project/page_stats/stat.dart';
import 'package:hive/hive.dart';

Future<void> initShopDatabase() async {
  var shopItemBox = await Hive.openBox('shopItemBox');

  if (shopItemBox.isEmpty) {
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
      shopItemBox.put(i, items[i]);
    }
  }
}

Future<void> initStatDatabase() async {
  var statBox = await Hive.openBox('statBox');

  if (statBox.isEmpty) {
    var items = [
      Stat(
          name: "Durée de jeu",
          petitValue: 10 * 1000,
          moyenValue: 10 * 1000,
          grandValue: 20 * 1000,
          globalValue: 40 * 1000,
          type: StatType.time),
      Stat(
          name: "Records",
          petitValue: 20 * 1000,
          moyenValue: 5 * 1000,
          grandValue: 30 * 1000,
          globalValue: 55 * 1000,
          type: StatType.time),
      Stat(
          name: "Parties jouées",
          petitValue: 5,
          moyenValue: 2,
          grandValue: 1,
          globalValue: 8,
          type: StatType.numeric),
      Stat(
          name: "Victoires",
          petitValue: 2,
          moyenValue: 1,
          grandValue: 0,
          globalValue: 3,
          type: StatType.numeric),
    ];
    for (var i = 0; i < items.length; i++) {
      statBox.put(i, items[i]);
    }
  }
}

Future<void> initUserDatabase() async {
  var userBox = await Hive.openBox('userBox');
  
  if (userBox.isEmpty) {
    userBox
    ..put("coins", 0)
    ..put("background", 0)
    ..put("bulb", 0);
  }

  
}

Future<void> initDatabase() async {
  Hive
    ..registerAdapter(ShopItemTypeAdapter())
    ..registerAdapter(ShopItemAdapter())
    ..registerAdapter(StatTypeAdapter())
    ..registerAdapter(StatAdapter())
    ..registerAdapter(UserAdapter());

  await initShopDatabase();
  await initStatDatabase();
  await initUserDatabase();
}
