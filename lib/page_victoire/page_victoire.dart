import 'package:akari_project/general/background.dart';
import 'package:akari_project/general/custom_app_bar.dart';
import 'package:akari_project/general/gradient_background.dart';
import 'package:akari_project/general/image_background.dart';
import 'package:akari_project/main.dart';
import 'package:akari_project/page_jeu/page_jeu.dart';
import 'package:akari_project/page_niveau/level.dart';
import 'package:akari_project/page_niveau/page_niveau.dart';
import 'package:akari_project/general/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

class PageVictoire extends StatelessWidget {
  final int time;
  final Level level;
  final int monney;
  final bool newRecord;

  const PageVictoire(
      {super.key,
      required this.time,
      required this.level,
      required this.monney,
      required this.newRecord});
  const PageVictoire(
      {super.key,
      required this.time,
      required this.level,
      required this.monney,
      required this.newRecord});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      extendBody: true,
      body: Center(
          child: ValueListenableBuilder<Box>(
              valueListenable: Hive.box('userBox').listenable(),
              builder: (context, box, _) {
                var theme = box.get("background");
                return BackgroundCustom(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "FÉLICITATIONS!",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 36),
                      ),
                      Visibility(
                        visible: newRecord,
                        child: const Text(
                          "NOUVEAU RECORD!",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          margin: const EdgeInsets.symmetric(
                              vertical: 30, horizontal: 30),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                DateFormat('mm:ss').format(
                                    DateTime.fromMillisecondsSinceEpoch(time)),
                                style: TextStyle(fontSize: 40),
                              ),
                              Text(
                                level.size == Size.petit
                                    ? "Petit"
                                    : level.size == Size.moyen
                                        ? "Moyen"
                                        : "Grand",
                                style: TextStyle(fontSize: 25),
                              ),
                              const SizedBox(
                                  height: 250,
                                  child: Image(
                                      image: AssetImage(
                                          "assets/images/victory_image.png"))),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    monney.toString(),
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  SizedBox(
                                    height: 50,
                                    child: Image(
                                        image: MyTheme.getTheme(theme).monnaie),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (context, animation1,
                                                    animation2) =>
                                                PageNiveau(),
                                            transitionDuration: Duration.zero,
                                            reverseTransitionDuration:
                                                Duration.zero,
                                          ),
                                          (Route<dynamic> route) =>
                                              route.isFirst,
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 5),
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: MyTheme.getTheme(theme).menu,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: const Text(
                                            "Menu",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      String niveau = level.size == Size.petit
                                          ? "Petit"
                                          : level.size == Size.moyen
                                              ? "Moyen"
                                              : "Grand";
                                      Share.share("J'ai réussi un " 
                                          "niveau Akari! de difficulté ${niveau} en "
                                          "${DateFormat('mm:ss').format(DateTime.fromMillisecondsSinceEpoch(time))}! "
                                          "\nViens essayer de me battre!");
                                    },
                                    child: Container(
                                        alignment: Alignment.center,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color:
                                              MyTheme.getTheme(theme).partager,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: const Text(
                                          "Partager",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Row(
                                  children: [
                                    ExpandedExpanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                        Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                              pageBuilder: (context, animation1,
                                                      animation2) =>
                                                  PageJeu(level: level),
                                              transitionDuration: Duration.zero,
                                              reverseTransitionDuration:
                                                  Duration.zero,
                                            ));
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color:
                                              MyTheme.getTheme(theme).rejouer,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: const Text(
                                          "Rejouer",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              })),
    );
  }
}
