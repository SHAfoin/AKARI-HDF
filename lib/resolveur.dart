import 'dart:math';

import 'package:akari_project/mecaniques/partie.dart';
import 'package:akari_project/models.dart';
import 'package:akari_project/solution.dart';

// valeur zone non éclairé = 0
// valeur zone éclairé = 1
// valeur ampoule = 5
// valeur mur = 6
final List<List<int>> matrice2 = [
  [0, 0, 6, 0, 0, 0, 0],
  [0, 6, 6, 0, 0, 6, 0],
  [0, 0, 0, 6, 6, 0, 6],
  [6, 0, 0, 0, 6, 0, 0],
  [6, 6, 6, 0, 0, 0, 0],
  [0, 0, 0, 6, 6, 0, 0],
  [6, 0, 0, 0, 0, 6, 6]
];
final List<List<int>> matrice3 = [
  [0, 0, 6, 0, 0, 0, 0],
  [0, 6, 6, 0, 0, 6, 0],
  [0, 0, 0, 6, 6, 0, 6]
];
final List<List<int>> matrice4 = [
  [0, 0, 6, 0],
  [0, 6, 6, 0],
  [0, 0, 0, 6],
  [0, 0, 0, 6],
  [6, 0, 0, 6]
];

class Generateur {
//Création de la matrice
  Grille creationMatrice(int length) {
    Grille mat = Grille.empty(length);
    for (int i = 0; i < length; i++) {
      for (int ii = 0; ii < length; ii++) {
        if (Random().nextInt(100) < 21) {
          mat.set(i, ii, Cases.mur);
        }
      }
    }
    return mat;
  }

//Fonction qui ajoute des ampoules de manière aléatoire pour afficher les nombres sur les murs
  void fillWithLight(Grille matrice) {
    int verif = 1;
    while (verif == 1) {
      verif = 0;
      var random = Random();
      var num1 = random.nextInt(matrice.length);
      var num2 = random.nextInt(matrice.length);
      if (matrice.isCase(num1, num2, Cases.nonEclaire)) {
        matrice.poserAmpoule(num1, num2);
        var (int i, int j) = matrice.nextCandidate();
        if (i != -1 && j != -1) {
          verif = 1;
        }
      } else {
        verif = 1;
      }
    }
  }

  void putNumberOnWalls(Grille mat) {
    for (int i = 0; i < mat.length; i++) {
      for (int j = 0; j < mat.length; j++) {
        if (mat.isCase(i, j, Cases.mur)) {
          int nbAmpoules = mat.nbVoisinsAmpoule(i, j);
          mat.set(i, j, Cases.getCase(10 + nbAmpoules));
        }
      }
    }
  }

// On a que soit des murs numérotés, soit des cases éclairés, soit des ampoules
// On regarde donc si on est pas sur une case éclairé ou une ampoule
  void retirerNmAlea(Grille matrice) {
    double p = 500;
    for (int k = 0; k < matrice.length; k++) {
      for (int i = 0; i < matrice.length; i++) {
        if ((matrice.isWall(k, i))) {
          var nombreAlea = Random().nextInt(1000);
          if (nombreAlea > p) {
            matrice.set(k, i, Cases.mur);
          }
        }
      }
    }
  }

  Grille generateurComplet(int length) {
    Grille matrice = creationMatrice(length);
    fillWithLight(matrice);
    putNumberOnWalls(matrice);
    retirerNmAlea(matrice);
    return Grille.onlyWalls(matrice);
  }
}

void main() {
  // Grille genGrille = Generateur().generateurComplet(9);
  // genGrille.afficherMat();
  // genGrille.afficherCandidats();
  // List<Grille> solutions = Solveur().backtrackSolveur(genGrille);
  // print(solutions.length);
  // for (var grille in solutions) {
  //   grille.afficherMat();
  //   print("\n");
  // }

  List<List<int>> matTest = [
    [0, 0, 0, 6, 1, 9, 9],
    [10, 0, 0, 0, 0, 6, 6],
    [6, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 11, 0, 11],
    [0, 0, 0, 0, 0, 0, 0],
    [0, 0, 6, 0, 0, 0, 0],
    [0, 11, 0, 0, 0, 0, 0]
  ];

  Partie partie = Partie(Grille(matTest));
  partie.afficherGrille();
  print("");

  partie.puzzle.enleverRouge();
  partie.afficherGrille();
  print("");
}
