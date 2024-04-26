import 'package:akari_project/nav_bar/nav_bar_central_button.dart';
import 'package:akari_project/nav_bar/nav_bar_side_button.dart';
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(children: [
      NavBarSideButton(
        side: Side.left,
        content: Column(
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
        side: Side.right,
        content: Column(
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
      NavBarCentralButton(),
    ]);
  }
}

// 
