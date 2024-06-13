import 'package:akari_project/general/themes.dart';
import 'package:akari_project/mecaniques/models.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class GrilleJeu extends StatelessWidget {
  final Cases caseActuelle;

  const GrilleJeu({super.key, required this.caseActuelle});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box>(
        valueListenable: Hive.box('userBox').listenable(),
        builder: (context, box, _) {
          return Builder(
            builder: (context) {
              switch (caseActuelle) {
                case Cases.eclaire:
                  return Container(
                    decoration: BoxDecoration(
                      color: Bulb.getAmpoule(box.get("bulb")).eclairage,
                      border: Border.all(
                        color: Colors.grey[700]!,
                        width: 1,
                      ),
                    ),
                  );
                case Cases.ampoule:
                  return Container(
                    decoration: BoxDecoration(
                      color: Bulb.getAmpoule(box.get("bulb")).eclairage,
                      border: Border.all(
                        color: Colors.grey[700]!,
                        width: 1,
                      ),
                    ),
                    child:
                        Image(image: Bulb.getAmpoule(box.get("bulb")).ampoule),
                  );
                case Cases.mur:
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(
                        color: Colors.grey[700]!,
                        width: 1,
                      ),
                    ),
                  );
                case Cases.ampouleRouge:
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      border: Border.all(
                        color: Colors.grey[700]!,
                        width: 1,
                      ),
                    ),
                    child:
                        Image(image: Bulb.getAmpoule(box.get("bulb")).ampoule),
                  );

                case Cases.zeroCell:
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(
                        color: Colors.grey[700]!,
                        width: 1,
                      ),
                    ),
                    child: const Center(
                        child: Text("0",
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.white, fontSize: 25))),
                  );
                case Cases.oneCell:
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(
                        color: Colors.grey[700]!,
                        width: 1,
                      ),
                    ),
                    child: const Center(
                        child: Text("1",
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.white, fontSize: 25))),
                  );
                case Cases.twoCell:
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(
                        color: Colors.grey[700]!,
                        width: 1,
                      ),
                    ),
                    child: const Center(
                        child: Text("2",
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.white, fontSize: 25))),
                  );
                case Cases.threeCell:
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(
                        color: Colors.grey[700]!,
                        width: 1,
                      ),
                    ),
                    child: const Center(
                        child: Text("3",
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.white, fontSize: 25))),
                  );
                case Cases.fourCell:
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(
                        color: Colors.grey[700]!,
                        width: 1,
                      ),
                    ),
                    child: const Center(
                        child: Text("4",
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.white, fontSize: 25))),
                  );
                case Cases.point:
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey[700]!,
                        width: 1,
                      ),
                    ),
                    child: FractionallySizedBox(
                      widthFactor: 0.5,
                      heightFactor: 0.5,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(100)),
                      ),
                    ),
                  );
                case Cases.pointEclaire:
                  return Container(
                    decoration: BoxDecoration(
                      color: Bulb.getAmpoule(box.get("bulb")).eclairage,
                      border: Border.all(
                        color: Colors.grey[700]!,
                        width: 1,
                      ),
                    ),
                    child: FractionallySizedBox(
                      widthFactor: 0.5,
                      heightFactor: 0.5,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(100)),
                      ),
                    ),
                  );
                case Cases.zeroCellWrong:
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(
                        color: Colors.grey[700]!,
                        width: 1,
                      ),
                    ),
                    child: const Center(
                        child: Text("0",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.red, fontSize: 25))),
                  );
                case Cases.oneCellWrong:
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(
                        color: Colors.grey[700]!,
                        width: 1,
                      ),
                    ),
                    child: const Center(
                        child: Text("1",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.red, fontSize: 25))),
                  );
                case Cases.twoCellWrong:
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(
                        color: Colors.grey[700]!,
                        width: 1,
                      ),
                    ),
                    child: const Center(
                        child: Text("2",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.red, fontSize: 25))),
                  );
                case Cases.threeCellWrong:
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(
                        color: Colors.grey[700]!,
                        width: 1,
                      ),
                    ),
                    child: const Center(
                        child: Text("3",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.red, fontSize: 25))),
                  );
                case Cases.fourCellWrong:
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(
                        color: Colors.grey[700]!,
                        width: 1,
                      ),
                    ),
                    child: const Center(
                        child: Text("4",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.red, fontSize: 25))),
                  );
                default:
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey[700]!,
                        width: 1,
                      ),
                    ),
                  );
              }
            },
          );
        });
  }
}
