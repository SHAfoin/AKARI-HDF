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
  List<bool> _selections = [true, false];

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        appBar: CustomAppBar(),
        bottomNavigationBar: const NavBar(
          selected: NavButton.right,
        ),
        body: GradientBackground(
            child: Center(
                child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Color(0xFF370617),
                border: Border.all(color: Color(0xFF370617), width: 15),
              ),
              child: ToggleButtons(
                children: [
                  Container(
                      width: 150,
                      child: Text(
                        "Background",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      )),
                  Container(
                      width: 150,
                      child: Text(
                        "Ampoules",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      ))
                ],
                isSelected: _selections,
                color: Colors.white,
                selectedColor: Color(0xFF370617),
                borderRadius: BorderRadius.circular(30),
                fillColor: Colors.white,
                onPressed: (index) {
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

                    controller.animateToPage(
                      index,
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                    );
                  });
                },
              ),
            ),
            Expanded(
              child: PageView(
                controller: controller,
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
        name: "Jaune",
        price: 50,
        isBought: true,
        pathToImage: "assets/images/shop_items/bulb_yellow.png",
        type: ShopItemType.bulb),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisExtent: 300,
        crossAxisCount: 2, // number of items in each row
        mainAxisSpacing: 15, // spacing between rows
        crossAxisSpacing: 15, // spacing between columns
      ),
      padding: EdgeInsets.only(
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
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisExtent: 300,
        crossAxisCount: 2, // number of items in each row
        mainAxisSpacing: 15, // spacing between rows
        crossAxisSpacing: 15, // spacing between columns
      ),
      padding: EdgeInsets.only(
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
