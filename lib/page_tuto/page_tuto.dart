import 'package:akari_project/themes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PageTuto extends StatelessWidget {
  const PageTuto({super.key});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.65,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "L'objectif du jeu est d'illuminer toutes les cases blanches de la grille. Pour cela, vous devez placer des ampoules qui illuminent le chemin vertical et horizontal. Cependant, leur lumière est bloquée par les cases noires.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, height: 0.9),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                      child: Text(
                        "1",
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Transform.translate(
                    offset: const Offset(0, -5),
                    child: const Text(
                      "Une case noire avec un chiffre indique le nombre exact d'ampoules présent à ses côtés.",
                      style: TextStyle(color: Colors.black, height: 0.9),
                    )),
              )
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 15.0, left: 5),
                child: SizedBox(
                  width: 30,
                  height: 30,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(40)),
                  ),
                ),
              ),
              Expanded(
                child: Transform.translate(
                    offset: const Offset(0, -5),
                    child: const Text(
                      "Appuyer une fois pour placer un point, lorsque vous savez qu’il n’y a pas d’ampoule ici.",
                      style: TextStyle(color: Colors.black, height: 0.9),
                    )),
              )
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 15.0, left: 5),
                child: SizedBox(
                  width: 30,
                  height: 30,
                  child: ValueListenableBuilder<Box>(
                      valueListenable: Hive.box('userBox').listenable(),
                      builder: (context, box, _) {
                        int bulb = box.get("bulb");
                        return Image(
                          image: Bulb.getAmpoule(bulb).ampoule,
                        );
                      }),
                ),
              ),
              Expanded(
                child: Transform.translate(
                    offset: const Offset(0, -5),
                    child: const Text(
                      "Appuyez à nouveau pour placer une ampoule et illuminer horizontalement et verticalement.",
                      style: TextStyle(color: Colors.black, height: 0.9),
                    )),
              )
            ],
          ),
          const Text(
            "Enfin appuyez une dernière fois pour enlever l’ampoule.",
            style: TextStyle(color: Colors.black, height: 0.9),
            textAlign: TextAlign.center,
          ),
          const Text(
            "La partie est terminée lorsque chaque case est illuminée en respectant les conditions des cases. Victoire !",
            style: TextStyle(color: Colors.black, height: 0.9),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
