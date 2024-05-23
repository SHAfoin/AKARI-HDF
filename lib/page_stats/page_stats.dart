import 'package:akari_project/general/custom_app_bar.dart';
import 'package:akari_project/general/gradient_background.dart';
import 'package:akari_project/nav_bar/nav_bar.dart';
import 'package:akari_project/page_stats/stat.dart';

import 'package:akari_project/page_stats/stat_tile.dart';
import 'package:flutter/material.dart';

class PageStats extends StatefulWidget {


  const PageStats({super.key});

  @override
  State<PageStats> createState() => _PageStatsState();
}

class _PageStatsState extends State<PageStats> {

  List<Stat> listeStat = [];

@override
  void initState() {
    
    super.initState();
    listeStat = [
    Stat(name: "Durée de jeu", petitValue: 10*1000, moyenValue: 10*1000, grandValue: 20*1000, globalValue: 40*1000, type: StatType.time),
    Stat(name: "Records", petitValue: 20*1000, moyenValue: 5*1000, grandValue: 30*1000, globalValue: 55*1000, type: StatType.time),
    Stat(name: "Parties jouées", petitValue: 5, moyenValue: 2, grandValue: 1, globalValue: 8, type: StatType.numeric),
    Stat(name: "Victoires", petitValue: 2, moyenValue: 1, grandValue: 0, globalValue: 3, type: StatType.numeric),
  ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        appBar: const CustomAppBar(),
        bottomNavigationBar: const NavBar(
          selected: NavButton.left,
        ),
        body: Center(
            child: GradientBackground(
                child: ListView.builder( 
                  padding: const EdgeInsets.only(bottom: 120),
                  shrinkWrap: true,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return StatTile(stat: listeStat[index]);
                  }
                    ),)));
  }
}
