import 'package:akari_project/page_stats/stat.dart';
import 'package:akari_project/page_stats/stat_tile_row.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatTile extends StatelessWidget {
  Stat stat;
  StatTile({super.key, required this.stat});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
      
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xFF9D0208),
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
    );
  }
}
