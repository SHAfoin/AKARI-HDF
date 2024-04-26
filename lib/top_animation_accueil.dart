import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopAnimation extends StatefulWidget {
  const TopAnimation({super.key});

  @override
  State<TopAnimation> createState() => _TopAnimationState();
}

// Classe d'une case
class Case {
  Color? color;
  double size;
  Widget? contenu;

  // Case noire avec chiffre
  Case.noirRemplie(this.size, int contenu) {
    color = Colors.black;
    this.contenu = Text(contenu.toString(),
        style: GoogleFonts.roboto(
          color: Colors.white,
          fontSize: 25,
        )); // obligé de mettre une autre police ; ConcertOne à un padding top intégré...
  }

  // Case noire sans texte
  Case.noirVide(this.size) {
    color = Colors.black;
    contenu = null;
  }

  // Case blanche sans texte
  Case.blancheVide(this.size) {
    color = Colors.white;
    contenu = null;
  }

  // Case blanche avec ampoule dedans
  Case.blancheRemplie(this.size) {
    color = Colors.white;
    contenu = Icon(Icons.lightbulb, color: Colors.yellow[600], size: size - 10);
  }
}

class _TopAnimationState extends State<TopAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  // faire 1/4 de la rotation seulement
  late Tween<double> turnsTween;

  @override
  void initState() {
    super.initState();
    // Faire la rotation en 6 sec, à l'infini, dans l'autre sens 1 fois sur 2
    controller =
        AnimationController(duration: const Duration(seconds: 3), vsync: this)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              controller.reverse();
            } else if (status == AnimationStatus.dismissed) {
              controller.forward();
            }
          });
    controller.forward();
  }

  // Essentiel pour delete l'animation à la fin
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Taille & type de chaque case
    Map<int, Case> cases = {
      1: Case.noirRemplie(50, 1),
      9: Case.blancheVide(40),
      12: Case.noirVide(55),
      14: Case.blancheRemplie(45),
      17: Case.noirRemplie(40, 0),
      20: Case.blancheVide(50)
    };

    return GridView.builder(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
      itemCount: 7 * 3,
      itemBuilder: (context, index) {
        if (cases.containsKey(index)) {
          if (index % 2 == 0) {
            turnsTween = Tween<double>(
              begin: -0.05,
              end: 0.05,
            );
          } else {
            turnsTween = Tween<double>(
              begin: 0.05,
              end: -0.05,
            );
          }
          turnsTween.begin = turnsTween.begin! * -1;
          turnsTween.end = turnsTween.end! * -1;
          // Animation
          return RotationTransition(
            turns: turnsTween
                .chain(CurveTween(curve: Curves.easeOutSine)) // Curve de vitesse
                .animate(controller),
            child: Transform.rotate(
              angle: (pi / 18) * (index % 7) -
                  (pi /
                      6), // (Random().nextInt(4) + 3), // angle de départ de la case
              child: Center(
                child: Container(
                  width: cases[index]?.size, // taille différente par case
                  height: cases[index]?.size,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: cases[index]?.color,
                  ),
                  child: Center(child: cases[index]?.contenu),
                ),
              ),
            ),
          );
        } else {
          return Container(color: null);
        }
      },
    );
  }
}
