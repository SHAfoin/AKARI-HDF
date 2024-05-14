import 'package:akari_project/nav_bar/nav_bar.dart';
import 'package:flutter/material.dart';

class PageShop extends StatelessWidget {
  const PageShop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: const NavBar(selected: NavButton.right,),
      body: Center( 
        child: SizedBox.expand(
            child: Container( // dégradé de fond
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFD00000),
                    Color(0xFFFFBA08),
                  ],
                )),
                child: Center(child: Text("Page de shop", textAlign: TextAlign.center,)),
                ),
    )));
  }
}