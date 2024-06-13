import 'dart:async';

import 'package:akari_project/general/background.dart';
import 'package:akari_project/general/custom_app_bar.dart';
import 'package:akari_project/general/themes.dart';
import 'package:akari_project/mecaniques/partie.dart';
import 'package:akari_project/page_jeu/grille_cases.dart';
import 'package:akari_project/page_jeu/page_jeu_button.dart';
import 'package:akari_project/page_tuto/page_tuto.dart';
import 'package:akari_project/page_niveau/level.dart';
import 'package:akari_project/page_victoire/page_victoire.dart';
import 'package:akari_project/utils/stopwatch.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class PageJeu extends StatefulWidget {
  final Level level;

  final bool newGame;

  PageJeu({super.key, required this.level, required this.newGame});

  @override
  State<PageJeu> createState() => _PageJeuState();
}

class _PageJeuState extends State<PageJeu> {
  late StopWatch stopwatch;
  late Timer t;
  bool isSolved = false;

  late Partie partie;

  @override
  void initState() {
    super.initState();

    stopwatch = StopWatch();
    stopwatch.start();

    partie = Partie.newGame(widget.level.size == Size.petit
        ? 5
        : widget.level.size == Size.moyen
            ? 7
            : 9);

    if (!widget.newGame) {
      var saveBox = Hive.box("saveBox");
      String partie_type;
      if (widget.level.size == Size.petit) {
        partie_type = "petit";
      } else if (widget.level.size == Size.moyen) {
        partie_type = "moyen";
      } else {
        partie_type = "grand";
      }
      partie = saveBox.get(partie_type);
      stopwatch.setMilliseconds = partie.timer;
    } else {
      updateStatsStart();
    }

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

  void updateStatsStart() {
    var statBox = Hive.box("statBox");

    // nombre de partie
    statBox.get("parties_jouees").globalValue++;

    switch (widget.level.size) {
      case Size.petit:
        statBox.get("parties_jouees").petitValue++;
        break;

      case Size.moyen:
        statBox.get("parties_jouees").moyenValue++;
        break;

      case Size.grand:
        statBox.get("parties_jouees").grandValue++;
        break;
      default:
    }
  }

  bool updateStatsEnd(int time, bool win) {
    bool newRecord = false;

    var statBox = Hive.box("statBox");
    statBox.get("duree_de_jeu").globalValue += time;
    if (win) {
      statBox.get("victoires").globalValue++;
    }
    if (statBox.get("records").globalValue > time ||
        statBox.get("records").globalValue == 0) {
      statBox.get("records").globalValue = time;
    }

    switch (widget.level.size) {
      case Size.petit:
        if (win) statBox.get("victoires").petitValue++;
        statBox.get("duree_de_jeu").petitValue += time;
        if (statBox.get("records").petitValue > time ||
            statBox.get("records").petitValue == 0) {
          statBox.get("records").petitValue = time;
          newRecord = true;
        }
        break;

      case Size.moyen:
        if (win) statBox.get("victoires").moyenValue++;
        if (statBox.get("records").moyenValue > time ||
            statBox.get("records").moyenValue == 0) {
          statBox.get("records").moyenValue = time;
          newRecord = true;
        }
        statBox.get("duree_de_jeu").moyenValue += time;
        break;

      case Size.grand:
        if (win) statBox.get("victoires").grandValue++;
        if (statBox.get("records").grandValue > time ||
            statBox.get("records").grandValue == 0) {
          statBox.get("records").grandValue = time;
          newRecord = true;
        }
        statBox.get("duree_de_jeu").grandValue += time;
        break;
      default:
    }

    return newRecord;
  }

  Future<void> victory() async {
    AudioPlayer victory = AudioPlayer();
    await victory.setSourceAsset("music/victory_sound.mp3");
    await victory.resume();
    bool newRecord = updateStatsEnd(stopwatch.elapsedMillis, isSolved);
    int time = stopwatch.elapsedMillis;
    await Future.delayed(const Duration(seconds: 2));
    Hive.box("saveBox").delete(widget.level.size == Size.petit
        ? "petit"
        : widget.level.size == Size.moyen
            ? "moyen"
            : "grand");
    Hive.box("userBox")
        .put("coins", Hive.box("userBox").get("coins") + howManyMonney(time));
    Navigator.pop(context);
    Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => PageVictoire(
            time: time,
            level: widget.level,
            monney: howManyMonney(time),
            newRecord: newRecord,
          ),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ));
  }

  int howManyMonney(int time) {
    int PETIT_MIN_TIME = 10 * 1000;
    int PETIT_MAX_TIME = 30 * 1000;
    int MOYEN_MIN_TIME = 20 * 1000;
    int MOYEN_MAX_TIME = 45 * 1000;
    int GRAND_MIN_TIME = 30 * 1000;
    int GRAND_MAX_TIME = 60 * 1000;

    int PETIT_MIN_MONNEY = 5;
    int PETIT_MAX_MONNEY = 10;
    int MOYEN_MIN_MONNEY = 15;
    int MOYEN_MAX_MONNEY = 30;
    int GRAND_MIN_MONNEY = 20;
    int GRAND_MAX_MONNEY = 40;

    if (widget.level.size == Size.petit) {
      if (time <= PETIT_MIN_TIME) {
        return PETIT_MAX_MONNEY;
      } else if (time > PETIT_MIN_TIME && time < PETIT_MAX_TIME) {
        double a = (PETIT_MAX_MONNEY - PETIT_MIN_MONNEY) /
            (PETIT_MIN_TIME - PETIT_MAX_TIME);
        double b = PETIT_MAX_MONNEY - a * PETIT_MIN_TIME;
        return (a * time + b).floor();
      } else {
        return PETIT_MIN_MONNEY;
      }
    } else if (widget.level.size == Size.moyen) {
      if (time <= MOYEN_MIN_TIME) {
        return MOYEN_MAX_MONNEY;
      } else if (time > MOYEN_MIN_TIME && time < MOYEN_MAX_TIME) {
        double a = (MOYEN_MAX_MONNEY - MOYEN_MIN_MONNEY) /
            (MOYEN_MIN_TIME - MOYEN_MAX_TIME);
        double b = MOYEN_MAX_MONNEY - a * MOYEN_MIN_TIME;
        return (a * time + b).floor();
      } else {
        return MOYEN_MIN_MONNEY;
      }
    } else {
      if (time <= GRAND_MIN_TIME) {
        return GRAND_MAX_MONNEY;
      } else if (time > GRAND_MIN_TIME && time < GRAND_MAX_TIME) {
        double a = (GRAND_MAX_MONNEY - GRAND_MIN_MONNEY) /
            (GRAND_MIN_TIME - GRAND_MAX_TIME);
        double b = GRAND_MAX_MONNEY - a * GRAND_MIN_TIME;
        return (a * time + b).floor();
      } else {
        return GRAND_MIN_MONNEY;
      }
    }
  }

  Future<bool?> _showBackDialog() {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Quitter ?'),
          content: const Text(
            'Votre partie sera sauvegardée.',
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Annuler'),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Quitter'),
              onPressed: () async {
                AudioPlayer back = AudioPlayer();
                await back.setSourceAsset("music/back_sound.mp3");
                await back.resume();
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    );
  }

  void saveGame() {
    var saveBox = Hive.box("saveBox");

    partie.timer = stopwatch.elapsedMillis;
    String partie_type;
    if (widget.level.size == Size.petit) {
      partie_type = "petit";
    } else if (widget.level.size == Size.moyen) {
      partie_type = "moyen";
    } else {
      partie_type = "grand";
    }
    saveBox.put(partie_type, partie);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (didPop) {
          return;
        }
        stopwatch.stop();
        bool choix = await _showBackDialog() ?? false;
        if (choix) {
          saveGame();
          Navigator.pop(context);
        } else {
          stopwatch.start();
        }
      },
      child: Scaffold(
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
                              stopwatch.elapsedMillis)),
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
                                ]),
                            IconButton(
                              onPressed: () {
                                if (!isSolved) {
                                  showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          const AlertDialog(
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
                              },
                              icon: const Icon(Icons.info_outline),
                              color: Colors.white,
                              iconSize: 35,
                            ),
                            Visibility(
                              maintainState: true,
                              maintainAnimation: true,
                              maintainSize: true,
                              visible: !isSolved,
                              child: OutlinedButton(
                                onPressed: () {
                                  setState(() {
                                    partie.annuler();
                                  });
                                },
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                child: const Text(
                                  "Annuler",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
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
                                    crossAxisCount: partie.puzzle.length,
                                  ),
                                  itemCount: partie.puzzle.length *
                                      partie.puzzle.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                        onTap: () async {
                                          if (!isSolved) {
                                            AudioPlayer touch = AudioPlayer();
                                            await touch.setSourceAsset(
                                                "music/touch_sound.mp3");
                                            await touch.resume();
                                            setState(() {
                                              isSolved = partie.cliquerCase(
                                                  index ~/ partie.puzzle.length,
                                                  index % partie.puzzle.length);
                                            });

                                            if (isSolved) {
                                              victory();
                                            }
                                          }
                                        },
                                        child: GrilleJeu(
                                            caseActuelle: partie.puzzle.get(
                                                index ~/ partie.puzzle.length,
                                                index % partie.puzzle.length)));
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
                                  onPressed: () async {
                                    AudioPlayer hint = AudioPlayer();
                                    await hint
                                        .setSourceAsset("music/hint_sound.mp3");
                                    await hint.resume();
                                    if (box.get("coins") >= 5) {
                                      box.put("coins",
                                          Hive.box("userBox").get("coins") - 5);
                                      setState(() {
                                        isSolved = partie.indice();
                                      });

                                      if (isSolved) {
                                        victory();
                                      }
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "-5",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                      SizedBox(
                                          height: 40,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, bottom: 8, left: 5),
                                            child: Image(
                                                image: MyTheme.getTheme(theme)
                                                    .monnaie),
                                          ))
                                    ],
                                  )),
                              PageJeuButton(
                                  color: MyTheme.getTheme(theme).solution,
                                  text: "Solution",
                                  onPressed: () async {
                                    AudioPlayer solution = AudioPlayer();
                                    await solution.setSourceAsset(
                                        "music/solution_sound.mp3");
                                    await solution.resume();

                                    setState(() {
                                      partie.resoudre();
                                    });
                                    isSolved = true;

                                    await Future.delayed(
                                        const Duration(seconds: 2));
                                    showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                                title: const Text("Résolu !"),
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
                                  onPressed: () async {
                                    AudioPlayer reset = AudioPlayer();
                                    await reset.setSourceAsset(
                                        "music/reset_sound.mp3");
                                    await reset.resume();
                                    partie.reset();
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
      ),
    );
  }
}
