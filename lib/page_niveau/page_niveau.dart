import 'package:akari_project/general/custom_app_bar.dart';
import 'package:akari_project/general/gradient_background.dart';
import 'package:akari_project/nav_bar/nav_bar.dart';
import 'package:akari_project/page_niveau/level.dart';
import 'package:akari_project/page_niveau/level_tile.dart';
import 'package:akari_project/themes.dart';
import 'package:flutter/material.dart';

class PageNiveau extends StatelessWidget {
  final List<Level> level = [
    Level(size: Size.petit, icon: "🥉", color: MyTheme.getTheme().petit),
    Level(size: Size.moyen, icon: "🥈", color: MyTheme.getTheme().moyen),
    Level(size: Size.grand, icon: "🥇", color: MyTheme.getTheme().grand)
  ];
  PageNiveau({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(),
        extendBody: true,
        bottomNavigationBar: const NavBar(
          selected: NavButton.central,
        ),
        body: Center(
            child: GradientBackground(
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 40, bottom: 170),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Transform.rotate(angle: -0.15, child: Text("Choisis ta partie !", style: TextStyle(color: Colors.white, fontSize: 35), textAlign: TextAlign.center,)),
                    LevelTile(
                      level: level[0],
                    ),
                    LevelTile(
                      level: level[1],
                    ),
                    LevelTile(
                      level: level[2],
                    ),
                  ],
                ),
              ),
            )));
  }
}
