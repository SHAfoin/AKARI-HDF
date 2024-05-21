import 'package:akari_project/general/custom_app_bar.dart';
import 'package:akari_project/general/gradient_background.dart';
import 'package:akari_project/page_jeu/page_jeu_button.dart';
import 'package:akari_project/page_niveau/level.dart';
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
          Text(
            widget.level.size == Size.petit
                ? "Petit"
                : widget.level.size == Size.moyen
                    ? "Moyen"
                    : "Grand",
            style: TextStyle(fontSize: 30, color: Colors.white),
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
                PageJeuButton(color: Color(0xFF6A040F), text: "Indice", onPressed: () {print(null);}),
                PageJeuButton(color: Color(0xFFD00000), text: "Solution", onPressed: () {print(null);}),
                PageJeuButton(color: Color(0xFFE85D04), text: "Quitter", onPressed: () {print(null);})
              ],
            ),
          )
        ],
      ))),
    );
  }
}
