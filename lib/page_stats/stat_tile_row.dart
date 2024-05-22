import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatTileRow extends StatelessWidget {
  final String statName;
  final bool isTitle;
  String stat;
  StatTileRow(
      {super.key,
      required this.statName,
      required this.isTitle,
      required this.stat});

  double titleStatFontSize = 25;
  double statFontSize = 20;

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
            child: Transform.translate(
              // POUR COMPENSER LA POLICE AVEC SON PADDING TOP INTEGRE...
              offset: Offset(0, -5),
              child: Text(
                statName,
                style: TextStyle(color: Colors.white, fontSize: isTitle ? titleStatFontSize : statFontSize),
              ),
            ),
          ),
          Container(
            width: isTitle ? 100 : 80,
            padding: EdgeInsets.only(bottom: 5, left: 5, right: 5),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Transform.translate(
                offset: Offset(0, -5),
                child: Text(
                  stat,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: isTitle ? titleStatFontSize : statFontSize, ),
                )),
          )
        ],
      ),
    );
  }
}
