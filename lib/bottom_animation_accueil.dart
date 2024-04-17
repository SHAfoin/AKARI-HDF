import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomAnimation extends StatefulWidget {
  const BottomAnimation({super.key});

  @override
  State<BottomAnimation> createState() => _BottomAnimationState();
}

// Classe d'une case
class Case {
  Color? color;
  double size;
  Widget? contenu;

  // Case noire avec chiffre
  Case.noirRemplie(double this.size, int contenu) {
    color = Colors.black;
    this.contenu = Text(contenu.toString(),
        style: GoogleFonts.roboto(
          color: Colors.white,
          fontSize: 25,
        )); // obligé de mettre une autre police ; ConcertOne à un padding top intégré...
  }

  // Case noire sans texte
  Case.noirVide(double this.size) {
    color = Colors.black;
    contenu = null;
  }

  // Case blanche sans texte
  Case.blancheVide(double this.size) {
    color = Colors.white;
    contenu = null;
  }

  // Case blanche avec ampoule dedans
  Case.blancheRemplie(double this.size) {
    color = Colors.white;
    contenu = Icon(Icons.lightbulb, color: Colors.yellow[600], size: size - 10);
  }
}

class _BottomAnimationState extends State<BottomAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  // faire 1/4 de la rotation seulement
  final Tween<double> turnsTween = Tween<double>(
    begin: 0,
    end: 0.25,
  );

  @override
  void initState() {
    super.initState();
    // Faire la rotation en 6 sec, à l'infini, dans l'autre sens 1 fois sur 2
    controller =
        AnimationController(duration: const Duration(seconds: 6), vsync: this)
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
      0: Case.noirRemplie(40, 1),
      5: Case.noirVide(50),
      8: Case.blancheVide(45),
      10: Case.blancheRemplie(60),
      13: Case.noirRemplie(45, 2),
      16: Case.noirVide(35),
      21: Case.blancheRemplie(40),
      25: Case.noirRemplie(50, 0),
      27: Case.blancheVide(50),
    };

    return GridView.builder(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
      itemCount: 7 * 4,
      itemBuilder: (context, index) {
        if (cases.containsKey(index)) {
          // Animation
          return RotationTransition(
            turns: turnsTween
                .chain(CurveTween(curve: Curves.easeInSine)) // Curve de vitesse
                .animate(controller),
            child: Transform.rotate(
              angle:
                  -pi / (Random().nextInt(4) + 3), // angle de départ de la case
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
