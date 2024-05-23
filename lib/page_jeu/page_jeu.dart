import 'package:akari_project/general/custom_app_bar.dart';
import 'package:akari_project/general/gradient_background.dart';
import 'package:akari_project/page_jeu/page_jeu_button.dart';
import 'package:akari_project/page_niveau/level.dart';
import 'package:akari_project/page_tuto/page_tuto.dart';
import 'package:akari_project/page_victoire/page_victoire.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class PageJeu extends StatefulWidget {
  final int gameSize;
  final Level level;
  const PageJeu({super.key, required this.gameSize, required this.level});

  @override
  State<PageJeu> createState() => _PageJeuState();
}

class _PageJeuState extends State<PageJeu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      extendBody: true,
      body: Center(
          child: GradientBackground(
              child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "02:03",
              style: TextStyle(fontSize: 60, color: Colors.white),
            ),
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
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              const PageTuto(),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                        ));
                  },
                  icon: const Icon(Icons.info_outline),
                  color: Colors.white,
                  iconSize: 35,
                )
              ],
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 350,
                maxHeight: 350,
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
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: widget.gameSize,
                        ),
                        itemCount: widget.gameSize * widget.gameSize,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              print(index);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.grey[400]!,
                                  width: 1,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PageJeuButton(
                      color: const Color(0xFF6A040F),
                      text: "Indice",
                      onPressed: () {
                        print(null);
                      }),
                  PageJeuButton(
                      color: const Color(0xFFD00000),
                      text: "Solution",
                      onPressed: () {
                        var userBox = Hive.box("userBox");
                        userBox.put("coins", userBox.get("coins") + 16);
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) =>
                                  const PageVictoire(),
                              transitionDuration: Duration.zero,
                              reverseTransitionDuration: Duration.zero,
                            ));
                      }),
                  PageJeuButton(
                      color: const Color(0xFFE85D04),
                      text: "Quitter",
                      onPressed: () {
                        print(null);
                      })
                ],
              ),
            )
          ],
        ),
      ))),
    );
  }
}
