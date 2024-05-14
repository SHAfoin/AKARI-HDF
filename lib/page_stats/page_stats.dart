import 'package:akari_project/general/custom_app_bar.dart';
import 'package:akari_project/nav_bar/nav_bar.dart';
import 'package:flutter/material.dart';

class PageStats extends StatelessWidget {
  const PageStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: CustomAppBar(),
      bottomNavigationBar: const NavBar(selected: NavButton.left,),
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
                child: Center(child: Text("Page de stats", textAlign: TextAlign.center,)),
                ),
    )));
  }
}