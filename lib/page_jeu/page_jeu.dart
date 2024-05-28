import 'dart:async';

import 'package:akari_project/general/background.dart';
import 'package:akari_project/general/custom_app_bar.dart';
import 'package:akari_project/general/gradient_background.dart';
import 'package:akari_project/general/image_background.dart';
import 'package:akari_project/general/themes.dart';
import 'package:akari_project/mecaniques/models.dart';
import 'package:akari_project/mecaniques/partie.dart';
import 'package:akari_project/page_jeu/page_jeu_button.dart';
import 'package:akari_project/page_tuto/page_tuto.dart';
import 'package:akari_project/page_niveau/level.dart';
import 'package:akari_project/page_victoire/page_victoire.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class PageJeu extends StatefulWidget {
  final int gameSize;
  final Level level;
  final Partie partie;
  PageJeu({super.key, required this.gameSize, required this.level})
      : partie = Partie(gameSize);

  @override
  State<PageJeu> createState() => _PageJeuState();
}

class _PageJeuState extends State<PageJeu> {
  late Stopwatch stopwatch;
  late Timer t;
  bool isSolved = false;

  @override
  void initState() {
    super.initState();
    stopwatch = Stopwatch();
    stopwatch.start();

    t = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      if (!isSolved) {
        setState(() {});
      }
    });
  }

  void dispose() {
    super.dispose();
    t.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      extendBody: true,
      body: Center(
        child: ValueListenableBuilder<Box>(
          valueListenable: Hive.box('userBox').listenable(),
          builder: (context, box, _) {
            int theme = box.get("background");
            return BackgroundCustom(
                child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat('mm:ss').format(
                        DateTime.fromMillisecondsSinceEpoch(
                            stopwatch.elapsedMilliseconds)),
                    style: TextStyle(fontSize: 60, color: Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 500,
                        maxHeight: 500,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Transform.translate(
                                offset: const Offset(0, -7),
                                child: Text(
                                  widget.level.size == Size.petit
                                      ? "Petit"
                                      : widget.level.size == Size.moyen
                                          ? "Moyen"
                                          : "Grand",
                                  style: const TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  if (!isSolved) {
                                    showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                              title: Text(
                                                "Tutoriel",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20),
                                              ),
                                              content: PageTuto(),
                                            ));
                                  }

                                  // Navigator.push(
                                  //     context,
                                  //     PageRouteBuilder(
                                  //       pageBuilder: (context, animation1, animation2) =>
                                  //           const PageTuto(),
                                  //       transitionDuration: Duration.zero,
                                  //       reverseTransitionDuration: Duration.zero,
                                  //     ));
                                },
                                icon: const Icon(Icons.info_outline),
                                color: Colors.white,
                                iconSize: 35,
                              )
                            ],
                          ),
                          Visibility(
                            visible: !isSolved,
                            child: OutlinedButton(
                                onPressed: () {
                                  setState(() {
                                    widget.partie.annuler();
                                  });
                                },
                                child: Text(
                                  "Annuler",
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                    color: Colors.white,
                                  ),
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 500,
                        maxHeight: 500,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(21),
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Container(
                              child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: widget.gameSize,
                                ),
                                itemCount: widget.gameSize * widget.gameSize,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () async {
                                      if (!isSolved) {
                                        setState(() {
                                          isSolved = widget.partie.cliquerCase(
                                              index ~/ widget.gameSize,
                                              index % widget.gameSize);
                                        });
                                        
                                        if (isSolved) {
                                          await Future.delayed(
                                      const Duration(seconds: 2));
                                          Navigator.pop(context);
                                          Navigator.push(
                                              context,
                                              PageRouteBuilder(
                                                pageBuilder: (context,
                                                        animation1,
                                                        animation2) =>
                                                    const PageVictoire(),
                                                transitionDuration:
                                                    Duration.zero,
                                                reverseTransitionDuration:
                                                    Duration.zero,
                                              ));
                                        }
                                      }
                                    },
                                    child: Builder(builder: (context) {
                                      switch (widget.partie.puzzle.get(
                                          index ~/ widget.gameSize,
                                          index % widget.gameSize)) {
                                        case Cases.eclaire:
                                          return Container(
                                            decoration: BoxDecoration(
                                              color: Colors.yellow,
                                              border: Border.all(
                                                color: Colors.grey[700]!,
                                                width: 1,
                                              ),
                                            ),
                                          );
                                        case Cases.ampoule:
                                          return Container(
                                            decoration: BoxDecoration(
                                              color: Colors.yellow,
                                              border: Border.all(
                                                color: Colors.grey[700]!,
                                                width: 1,
                                              ),
                                            ),
                                            child: Image.asset(
                                                "assets/images/shop_items/bulb_green.png"),
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
                                            child: Image.asset(
                                                "assets/images/shop_items/bulb_green.png"),
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
                                            child: Center(
                                                child: Text("0",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 25))),
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
                                            child: Center(
                                                child: Text("1",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 25))),
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
                                            child: Center(
                                                child: Text("2",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 25))),
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
                                            child: Center(
                                                child: Text("3",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 25))),
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
                                            child: Center(
                                                child: Text("4",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 25))),
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
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100)),
                                              ),
                                            ),
                                          );
                                        case Cases.pointEclaire:
                                          return Container(
                                            decoration: BoxDecoration(
                                              color: Colors.yellow,
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
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100)),
                                              ),
                                            ),
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
                                    }),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      child: Visibility(
                        maintainState: true,
                        maintainAnimation: true,
                        maintainSize: true,
                        visible: !isSolved,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            PageJeuButton(
                                color: MyTheme.getTheme(theme).indice,
                                text: "Indice",
                                onPressed: () {
                                  print(null);
                                }),
                            PageJeuButton(
                                color: MyTheme.getTheme(theme).solution,
                                text: "Solution",
                                onPressed: () async {
                                  var userBox = Hive.box("userBox");
                                  setState(() {
                                    widget.partie.resoudre();
                                  });
                                  isSolved = true;
                                  userBox.put(
                                      "coins", userBox.get("coins") + 16);
                                  await Future.delayed(
                                      const Duration(seconds: 2));
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                              title: Text("Résolu !"),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text(
                                                      'Retour au menu'),
                                                )
                                              ]));
                                }),
                            PageJeuButton(
                                color: MyTheme.getTheme(theme).quitter,
                                text: "Reset",
                                onPressed: () {
                                  setState(() {
                                    widget.partie.reset();
                                  });
                                })
                          ],
                        ),
                      )),
                ],
              ),
            ));
          },
        ),
      ),
    );
  }
}
