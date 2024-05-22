import 'package:akari_project/general/custom_app_bar.dart';
import 'package:akari_project/general/gradient_background.dart';
import 'package:akari_project/page_jeu/page_jeu_button.dart';
import 'package:akari_project/page_niveau/level.dart';
import 'package:akari_project/page_tuto/page_tuto.dart';
import 'package:akari_project/page_victoire/page_victoire.dart';
import 'package:akari_project/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      appBar: CustomAppBar(),
      extendBody: true,
      body: Center(
          child: GradientBackground(
              child: Column(
        children: [
          Text(
            "02:03",
            style: TextStyle(fontSize: 60, color: Colors.white),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Transform.translate(
                  offset: Offset(0, -7),
                  child: Text(
                    widget.level.size == Size.petit
                        ? "Petit"
                        : widget.level.size == Size.moyen
                            ? "Moyen"
                            : "Grand",
                    style: TextStyle(fontSize: 30, color: Colors.white,),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) =>
                                PageTuto(),
                            transitionDuration: Duration.zero,
                            reverseTransitionDuration: Duration.zero,
                          ));
                    },
                    icon: Icon(Icons.info_outline), color: Colors.white, iconSize: 35,)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: FractionallySizedBox(
              widthFactor: 0.9,
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
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PageJeuButton(
                    color: MyTheme.getTheme().indice,
                    text: "Indice",
                    onPressed: () {
                      print(null);
                    }),
                PageJeuButton(
                    color: MyTheme.getTheme().solution,
                    text: "Solution",
                    onPressed: () {
                      Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) =>
                  PageVictoire(),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ));
                    }),
                PageJeuButton(
                    color: MyTheme.getTheme().quitter,
                    text: "Quitter",
                    onPressed: () {
                      print(null);
                    })
              ],
            ),
          )
        ],
      ))),
    );
  }
}
