import 'package:akari_project/general/custom_app_bar.dart';
import 'package:akari_project/general/gradient_background.dart';
import 'package:akari_project/nav_bar/nav_bar.dart';
import 'package:akari_project/page_stats/stat.dart';

import 'package:akari_project/page_stats/stat_tile.dart';
import 'package:flutter/material.dart';

class PageStats extends StatefulWidget {


  PageStats({super.key});

  @override
  State<PageStats> createState() => _PageStatsState();
}

class _PageStatsState extends State<PageStats> {

  List<Stat> listeStat = [];

@override
  void initState() {
    
    super.initState();
    listeStat = [
    Stat(name: "Durée de jeu", petitValue: "00:10", moyenValue: "00:10", grandValue: "00:20", globalValue: "00:40"),
    Stat(name: "Records", petitValue: "00:20", moyenValue: "00:05", grandValue: "00:30", globalValue: "00:55"),
    Stat(name: "Parties jouées", petitValue: "5", moyenValue: "2", grandValue: "1", globalValue: "8"),
    Stat(name: "Victoires", petitValue: "2", moyenValue: "1", grandValue: "0", globalValue: "3"),
  ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        appBar: CustomAppBar(),
        bottomNavigationBar: const NavBar(
          selected: NavButton.left,
        ),
        body: Center(
            child: GradientBackground(
                child: ListView.builder( 
                  padding: EdgeInsets.only(bottom: 120),
                  shrinkWrap: true,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return StatTile(stat: listeStat[index]);
                  }
                    ),)));
  }
}
