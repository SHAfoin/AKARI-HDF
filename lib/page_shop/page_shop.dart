import 'package:akari_project/general/custom_app_bar.dart';
import 'package:akari_project/general/gradient_background.dart';
import 'package:akari_project/nav_bar/nav_bar.dart';
import 'package:flutter/material.dart';

class PageShop extends StatelessWidget {
  const PageShop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: CustomAppBar(),
      bottomNavigationBar: const NavBar(selected: NavButton.right,),
      body: Center( 
        child: GradientBackground(child: Center(child: Text("Page de shop", textAlign: TextAlign.center,)))));
  }
}