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
          id: 0,
          price: 50,
          isBought: true,
          pathToImage: "assets/images/shop_items/background_red.png",
          type: ShopItemType.background),
      ShopItem(
          name: "Bleu",
          id: 1,
          price: 50,
          isBought: false,
          pathToImage: "assets/images/shop_items/background_blue.png",
          type: ShopItemType.background),
      ShopItem(
          id: 2,
          name: "Vert",
          price: 50,
          isBought: false,
          pathToImage: "assets/images/shop_items/background_green.png",
          type: ShopItemType.background),
      ShopItem(
          name: "Minecraft",
          price: 500,
          id: 3,
          isBought: false,
          pathToImage: "assets/images/shop_items/background_minecraft.png",
          type: ShopItemType.background),
      ShopItem(
          name: "Steampunk",
          price: 300,
          id: 4,
          isBought: false,
          pathToImage: "assets/images/shop_items/background_steampunk.jpg",
          type: ShopItemType.background),
      ShopItem(
          name: "Sakura",
          price: 300,
          id: 5,
          isBought: false,
          pathToImage: "assets/images/shop_items/background_sakura.jpg",
          type: ShopItemType.background),
      ShopItem(
          name: "Jaune",
          price: 50,
          id: 0,
          isBought: true,
          pathToImage: "assets/images/shop_items/bulb_yellow.png",
          type: ShopItemType.bulb),
      ShopItem(
          name: "Bleu",
          price: 50,
          id: 1,
          isBought: false,
          pathToImage: "assets/images/shop_items/bulb_blue.png",
          type: ShopItemType.bulb),
      ShopItem(
          name: "Vert",
          price: 50,
          id: 2,
          isBought: false,
          pathToImage: "assets/images/shop_items/bulb_green.png",
          type: ShopItemType.bulb),
      ShopItem(
          name: "Torche",
          price: 200,
          id: 3,
          isBought: false,
          pathToImage: "assets/images/shop_items/bulb_minecraft.png",
          type: ShopItemType.bulb),
      ShopItem(
          name: "Lampion",
          price: 200,
          id: 4,
          isBought: false,
          pathToImage: "assets/images/shop_items/bulb_japanese.png",
          type: ShopItemType.bulb),
      ShopItem(
          name: "Steampunk",
          price: 200,
          id: 5,
          isBought: false,
          pathToImage: "assets/images/shop_items/bulb_steampunk.png",
          type: ShopItemType.bulb),
    ];

    for (var i = 0; i < items.length; i++) {
      var name = items[i].type == ShopItemType.background
          ? "background_${items[i].name}"
          : "bulb${items[i].name}";
      shopItemBox.put(name, items[i]);
    }
  }
}

Future<void> initStatDatabase() async {
  var statBox = await Hive.openBox('statBox');

  if (statBox.isEmpty) {
    var items = [
      Stat(
          id: "duree_de_jeu",
          name: "Durée de jeu",
          petitValue: 0,
          moyenValue: 0,
          grandValue: 0,
          globalValue: 0,
          type: StatType.time),
      Stat(
          id: "records",
          name: "Records",
          petitValue: 0,
          moyenValue: 0,
          grandValue: 0,
          globalValue: 0,
          type: StatType.time),
      Stat(
          id: "parties_jouees",
          name: "Parties jouées",
          petitValue: 0,
          moyenValue: 0,
          grandValue: 0,
          globalValue: 0,
          type: StatType.numeric),
      Stat(
          id: "victoires",
          name: "Victoires",
          petitValue: 0,
          moyenValue: 0,
          grandValue: 0,
          globalValue: 0,
          type: StatType.numeric),
    ];
    for (var i = 0; i < items.length; i++) {
      statBox.put(items[i].id, items[i]);
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

  initShopDatabase();
  initStatDatabase();
  initUserDatabase();
}
