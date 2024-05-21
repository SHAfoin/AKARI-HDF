import 'package:akari_project/general/custom_app_bar.dart';
import 'package:akari_project/general/gradient_background.dart';
import 'package:flutter/material.dart';

class PageTuto extends StatelessWidget {
  const PageTuto({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      extendBody: true,
      body: Center(
          child: GradientBackground(
              child: FractionallySizedBox(
        widthFactor: 0.8,
        heightFactor: 0.8,
        child: Container(
          padding: const EdgeInsets.only(left: 15, right:15, top: 10, bottom: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Comment jouer à Akari ?",
                style: TextStyle(color: Colors.black, fontSize: 20),
                textAlign: TextAlign.center,
              ),
              Text(
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
                        child: Center(
                          child: Transform.translate(
                            offset: Offset(0, -5),
                            child: Text("1",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20
                            ),),
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Transform.translate(
                        offset: Offset(0, -5),
                        child: Text(
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
                        offset: Offset(0, -5),
                        child: Text(
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
                      child: Image(
                      image: AssetImage("assets/images/shop_items/bulb_yellow.png"),
                  ),
                    ),
                  ),
                  Expanded(
                    child: Transform.translate(
                        offset: Offset(0, -5),
                        child: Text(
                          "Appuyez à nouveau pour placer une ampoule et illuminer horizontalement et verticalement.",
                          style: TextStyle(color: Colors.black, height: 0.9),
                        )),
                  )
                ],
              ),
              Text("Enfin appuyez une dernière fois pour enlever l’ampoule.", style: TextStyle(color: Colors.black, height: 0.9),textAlign: TextAlign.center,),

              Text("La partie est terminée lorsque chaque case est illuminée en respectant les conditions des cases. Victoire !", style: TextStyle(color: Colors.black, height: 0.9),textAlign: TextAlign.center,),
            ],
          ),
        ),
      ))),
    );
  }
}
