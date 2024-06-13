import 'package:akari_project/page_stats/stat.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StatTileRow extends StatelessWidget {
  final String statName;
  final bool isTitle;
  final int stat;
  final StatType type;

  const StatTileRow(
      {super.key,
      required this.statName,
      required this.isTitle,
      required this.stat,
      required this.type});

  final double titleStatFontSize = 25;
  final double statFontSize = 20;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
              padding: EdgeInsets.only(left: isTitle ? 0 : 40),
              child: Text(
                statName,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: isTitle ? titleStatFontSize : statFontSize),
              )),
          Container(
            width: isTitle ? 100 : 80,
            padding: const EdgeInsets.only(bottom: 5, left: 5, right: 5),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Text(
              type == StatType.numeric
                  ? stat.toString()
                  : stat < 36000000
                      ? DateFormat('mm:ss')
                          .format(DateTime.fromMillisecondsSinceEpoch(stat))
                      : DateFormat('hh:mm')
                          .format(DateTime.fromMillisecondsSinceEpoch(stat)),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isTitle ? titleStatFontSize : statFontSize,
              ),
            ),
          )
        ],
      ),
    );
  }
}
