import 'dart:math';

import 'package:akari_project/page_accueil/case_accueil.dart';
import 'package:flutter/material.dart';

enum Side {bottom, top}

class AnimationAccueil extends StatefulWidget {

  final Side side;

  const AnimationAccueil({super.key, required this.side});

  @override
  State<AnimationAccueil> createState() => _AnimationAccueilState();
}

class _AnimationAccueilState extends State<AnimationAccueil>
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
  Map<int, Case> cases;
  if (widget.side == Side.bottom) {
    cases = {
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
  } else {
      cases = {
      1: Case.noirRemplie(50, 1),
      9: Case.blancheVide(40),
      12: Case.noirVide(55),
      14: Case.blancheRemplie(45),
      17: Case.noirRemplie(40, 0),
      20: Case.blancheVide(50)
    };
  }

    return GridView.builder(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
      itemCount: 7 * ((widget.side == Side.top) ? 3 : 4),
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
            );}
          // Animation
          return RotationTransition(
            turns: turnsTween
                .chain(CurveTween(curve: Curves.easeOutSine)) // Curve de vitesse
                .animate(controller),
            child: Transform.rotate(
              angle:
                  (-pi/18) * (index%7) + (pi/6), // angle de départ de la case
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
