import 'package:akari_project/nav_bar/nav_bar_central_button.dart';
import 'package:akari_project/nav_bar/nav_bar_side_button.dart';
import 'package:akari_project/page_niveau/page_niveau.dart';
import 'package:akari_project/page_shop/page_shop.dart';
import 'package:akari_project/page_stats/page_stats.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum NavButton {central, left, right}

class NavBar extends StatefulWidget {

  final NavButton? selected;
  const NavBar({super.key, required this.selected});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {

  @override
  Widget build(BuildContext context) {
    
    return Stack(children: [

     NavBarSideButton(
        selected: (widget.selected == NavButton.left),
        pageDestination: PageStats(),
        side: ButtonSide.left,
        content: const Column(
          children: [
            Icon(
              Icons.format_list_numbered,
              color: Colors.white,
              size: 50,
            ),
            Text(
              "Stats",
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ],
        ),
      ),
       NavBarSideButton(
        pageDestination: const PageShop(),
        selected: (widget.selected == NavButton.right),
        side: ButtonSide.right,
        content: const Column(
          children: [
            Icon(
              Icons.storefront_outlined,
              color: Colors.white,
              size: 50,
            ),
            Text(
              "Shop",
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ],
        ),
      ),
      NavBarCentralButton(selected: (widget.selected == NavButton.central),
    )]);
  }
}

// 
