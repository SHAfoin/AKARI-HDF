import 'package:akari_project/general/custom_app_bar.dart';
import 'package:akari_project/general/gradient_background.dart';
import 'package:akari_project/nav_bar/nav_bar.dart';
import 'package:akari_project/page_shop/shop_item.dart';
import 'package:akari_project/page_shop/shop_tile.dart';
import 'package:flutter/material.dart';

class PageShop extends StatefulWidget {
  const PageShop({super.key});

  @override
  State<PageShop> createState() => _PageShopState();
}

class _PageShopState extends State<PageShop> {
  List<ShopItem> items = [];

  final controller = PageController();
  final List<bool> _selections = [true, false];

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void updateButtons(int index) {
    setState(() {
      for (int buttonIndex = 0;
          buttonIndex < _selections.length;
          buttonIndex++) {
        if (buttonIndex == index) {
          _selections[buttonIndex] = true;
        } else {
          _selections[buttonIndex] = false;
        }
      }
    });
  }

  void changePage(int index) {
    updateButtons(index);
    controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        appBar: const CustomAppBar(),
        bottomNavigationBar: const NavBar(
          selected: NavButton.right,
        ),
        body: GradientBackground(
            child: Center(
                child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: const Color(0xFF370617),
                border: Border.all(color: const Color(0xFF370617), width: 15),
              ),
              child: ToggleButtons(
                isSelected: _selections,
                color: Colors.white,
                selectedColor: const Color(0xFF370617),
                borderRadius: BorderRadius.circular(30),
                fillColor: Colors.white,
                onPressed: changePage,
                children: [
                  SizedBox(
                      width: 150,
                      child: Transform.translate(
              // POUR COMPENSER LA POLICE AVEC SON PADDING TOP INTEGRE...
              offset: const Offset(0, -5),
                        child: const Text(
                          "Background",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),
                        ),
                      )),
                  SizedBox(
                      width: 150,
                      child: Transform.translate(
              // POUR COMPENSER LA POLICE AVEC SON PADDING TOP INTEGRE...
              offset: const Offset(0, -5),
                        child: const Text(
                          "Ampoules",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),
                        ),
                      ))
                ],
              ),
            ),
            Expanded(
              child: PageView(
                controller: controller,
                onPageChanged: updateButtons,
                children: [
                  BackgroundShop(),
                  AmpouleShop(),
                ],
              ),
            ),
          ],
        ))));
  }
}

class BackgroundShop extends StatelessWidget {
  List<ShopItem> items = [
    ShopItem(
        name: "Jaune/Rouge",
        price: 50,
        isBought: true,
        pathToImage: "assets/images/shop_items/background_red.png",
        type: ShopItemType.bulb),
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
  ];

  BackgroundShop({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisExtent: 300,
        crossAxisCount: 2, // number of items in each row
        mainAxisSpacing: 15, // spacing between rows
        crossAxisSpacing: 15, // spacing between columns
      ),
      padding: const EdgeInsets.only(
          top: 15, left: 15, right: 15, bottom: 120), // padding around the grid
      itemCount: items.length, // total number of items
      itemBuilder: (context, index) {
        return ShopTile(
          item: items[index],
        );
      },
    );
  }
}

class AmpouleShop extends StatelessWidget {
  List<ShopItem> items = [
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

  AmpouleShop({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisExtent: 300,
        crossAxisCount: 2, // number of items in each row
        mainAxisSpacing: 15, // spacing between rows
        crossAxisSpacing: 15, // spacing between columns
      ),
      padding: const EdgeInsets.only(
          top: 15, left: 15, right: 15, bottom: 120), // padding around the grid
      itemCount: items.length, // total number of items
      itemBuilder: (context, index) {
        return ShopTile(
          item: items[index],
        );
      },
    );
  }
}
