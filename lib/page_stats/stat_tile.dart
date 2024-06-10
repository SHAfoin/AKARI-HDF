import 'package:akari_project/page_stats/stat.dart';
import 'package:akari_project/page_stats/stat_tile_row.dart';
import 'package:akari_project/general/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class StatTile extends StatelessWidget {
  Stat stat;
  StatTile({super.key, required this.stat});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box>(
      valueListenable: Hive.box('userBox').listenable(),
      builder: (context, box, widget) {
        var theme = box.get("background");
      return Padding(
        padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
        
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: MyTheme.getTheme(theme).stats,
          ),
          child: Column(
            children: [
              StatTileRow(statName: stat.name, isTitle: true, stat: stat.globalValue, type: stat.type),
              StatTileRow(statName: "Petit", isTitle: false, stat: stat.petitValue, type: stat.type),
              StatTileRow(statName: "Moyen", isTitle: false, stat: stat.moyenValue, type: stat.type),
              StatTileRow(statName: "Grand", isTitle: false, stat: stat.grandValue, type: stat.type),
            ],
          ),
        ),
      );},
    );
  }
}
