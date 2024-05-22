import 'package:akari_project/page_jeu/page_jeu.dart';
import 'package:akari_project/page_niveau/level.dart';
import 'package:flutter/material.dart';

class LevelTile extends StatelessWidget {
  final Level level;
  const LevelTile({super.key, required this.level});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        int gameSize;
        if (level.size == Size.petit) {
          gameSize = 5;
        } else if (level.size == Size.moyen) {
          gameSize = 7;
        } else {
          gameSize = 9;
        }
        Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) =>
                  PageJeu(gameSize: gameSize, level: level),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ));
      },
      child: Transform.rotate(
        angle: -0.15,
        child: Container(
          margin: const EdgeInsets.all(10),
          height: 100,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: const Offset(0, 7),
              ),
            ],
            color: level.color,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white),
                    child: Center(
                        child: Text(
                      level.icon,
                      style: const TextStyle(fontSize: 30),
                    ))),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    level.size == Size.petit
                        ? "Petit"
                        : level.size == Size.moyen
                            ? "Moyen"
                            : "Grand",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                  const Text(
                    "Meilleur temps : 00:30",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
