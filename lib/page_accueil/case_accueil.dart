import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Classe d'une case
class Case {
  Color? color;
  double size;
  Widget? contenu;

  // Case noire avec chiffre
  Case.noirRemplie(this.size, int contenu) {
    color = Colors.black;
    this.contenu = Text(contenu.toString(),
        style: const TextStyle(
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
  Case.blancheRemplie(this.size, AssetImage image) {
    color = Colors.white;
    contenu = Image(image: image, width: size, height: size);
  }
}
