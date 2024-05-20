import 'dart:math';

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
          mat.removeCandidate(i, ii);
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
        if ((!matrice.isCase(k, i, Cases.nonEclaire)) &&
            (!matrice.isCase(k, i, Cases.ampoule))) {
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

class Partie {
  Grille puzzle;
  List<Grille> listeAction = [];

  Partie(this.puzzle);
//Fonction pour quand dans partie
  void cliquerCase(int k, int i) {
    listeAction.add(Grille.copy(puzzle));
    if (puzzle.isCase(k, i, Cases.nonEclaire) ||
        puzzle.isCase(k, i, Cases.eclaire)) {
      puzzle.set(k, i, Cases.point);
    } else if (puzzle.isCase(k, i, Cases.point)) {
      puzzle.poserAmpoule(k, i);
    } else if (puzzle.isCase(k, i, Cases.ampoule) ||
        puzzle.isCase(k, i, Cases.ampouleRouge)) {
      puzzle.enleverAmpoule(k, i);
    }
  }

  void annuler() {
    if (listeAction.isNotEmpty) {
      puzzle = listeAction.removeLast();
    }
  }

  void afficherGrille() {
    puzzle.afficherMat();
  }
}

void main() {
  // Grille genGrille = Generateur().generateurComplet(15);
  // genGrille.afficherMat();
  // genGrille.afficherCandidats();
  // List<Grille> solutions = Solveur().backtrackSolveur(genGrille);
  // print(solutions.length);
  // for (var grille in solutions) {
  //   grille.afficherMat();
  //   print("\n");
  // }

  List<List<int>> matTest = [
    [0, 1, 0, 6, 0, 0, 0],
    [10, 5, 1, 1, 1, 6, 6],
    [6, 1, 0, 0, 0, 0, 0],
    [0, 1, 0, 0, 11, 0, 11],
    [0, 1, 0, 0, 0, 0, 1],
    [0, 1, 6, 1, 1, 1, 5],
    [0, 11, 0, 0, 0, 0, 1]
  ];

  Partie partie = Partie(Grille(matTest));
  partie.afficherGrille();
  print("");

  print("1 1");
  partie.cliquerCase(1, 1);
  partie.afficherGrille();
  print("");

  print("5 3 x2");
  partie.cliquerCase(5, 3);
  partie.cliquerCase(5, 3);
  partie.afficherGrille();
  print("");

  print("5 3");
  partie.cliquerCase(5, 3);
  partie.afficherGrille();
  print("");

  print("5 3 x2\n 5 6");
  partie.cliquerCase(5, 3);
  partie.cliquerCase(5, 3);
  partie.cliquerCase(5, 6);
  partie.afficherGrille();
  print("");

  print("5 6");
  partie.cliquerCase(5, 6);
  partie.afficherGrille();
  print("");

  print("1 3 x2");
  partie.cliquerCase(1, 3);
  partie.cliquerCase(1, 3);
  partie.afficherGrille();
  print("");

  print("annuler");
  partie.annuler();
  partie.afficherGrille();
  print("");
}
