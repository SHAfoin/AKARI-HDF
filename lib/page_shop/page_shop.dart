import 'package:akari_project/general/custom_app_bar.dart';
import 'package:akari_project/general/gradient_background.dart';
import 'package:akari_project/main.dart';
import 'package:akari_project/nav_bar/nav_bar.dart';
import 'package:akari_project/page_shop/shop_item.dart';
import 'package:akari_project/page_shop/shop_tile.dart';
import 'package:akari_project/themes.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PageShop extends StatefulWidget {
  const PageShop({super.key});

  @override
  State<PageShop> createState() => _PageShopState();
}

class _PageShopState extends State<PageShop> {

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
        appBar: CustomAppBar(),
        bottomNavigationBar: NavBar(
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
                color: MyTheme.getTheme().shop,
                border: Border.all(color: MyTheme.getTheme().shop, width: 15),
              ),
              child: ToggleButtons(
                isSelected: _selections,
                color: Colors.white,
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
                selectedColor: MyTheme.getTheme().shop,
              ),
            ),
            TextButton(
                onPressed: () {
                  setState(() {
                    MyTheme.selectTheme(MyTheme.choix + 1);
                    Navigator.pushAndRemoveUntil(
                                context,
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation1, animation2) =>
                                          MainApp(),
                                  transitionDuration: Duration.zero,
                                  reverseTransitionDuration: Duration.zero,
                                ),(Route<dynamic> route) => route.isFirst,
                              );
                  });
                  
                },
                child: const Text("Change Theme")),
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

  BackgroundShop({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box>(
      valueListenable: Hive.box('shopItemBox').listenable(),
      builder: (context, box, widget) {
        
            var items = box!.values.where((item) => item.type == ShopItemType.background).toList();
           

            return GridView.builder(
              itemCount: items.length,
              padding: const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 120),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 300,
                crossAxisCount: 2, // number of items in each row
                mainAxisSpacing: 15, // spacing between rows
                crossAxisSpacing: 15
              ),
              itemBuilder: (context, index) {
                return ShopTile(
                  item: items[index],
                );
              },
            );
          
        } 
      
    );
  }
}

class AmpouleShop extends StatelessWidget {
  AmpouleShop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box>(
      valueListenable: Hive.box('shopItemBox').listenable(),
      builder: (context, box, widget) {
        
            var items = box!.values.where((item) => item.type == ShopItemType.bulb).toList();

            return GridView.builder(
              itemCount: items.length,
              padding: const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 120),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 300,
                crossAxisCount: 2, // number of items in each row
                mainAxisSpacing: 15, // spacing between rows
                crossAxisSpacing: 15
              ),
              itemBuilder: (context, index) {
                return ShopTile(
                  item: items[index],
                );
              },
            );
          
        } 
      
    );
  }
}
