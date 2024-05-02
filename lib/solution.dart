import 'package:akari_project/resolveur.dart';

enum Cases {
  caseNonEclaire(0),
  mur(6),
  caseEclaire(1),
  ampoule(5),
  ampouleRouge(9),
  point(99),
  zeroCell(10),
  oneCell(11),
  twoCell(12),
  threeCell(13),
  fourCell(14);

  final int value;
  const Cases(this.value);
}

class TrivialSolver {
  final List<List<int>> matrice;
  final List<List<bool>> possibilite;

  afficherMat() {
    for (var i = 0; i < matrice.length; i++) {
      print(matrice[i]);
    }
    for (var i = 0; i < possibilite.length; i++) {
      print(possibilite[i]);
    }
  }

  TrivialSolver(this.matrice)
      : possibilite = List<List<bool>>.generate(
            matrice.length,
            (i) => List<bool>.generate(matrice.length,
                (j) => matrice[i][j] == Cases.caseNonEclaire.value));

  zerosCell() {
    for (var i = 0; i < matrice.length; i++) {
      for (var j = 0; j < matrice.length; j++) {
        if (matrice[i][j] == Cases.zeroCell.value) {
          if (i - 1 >= 0 && matrice[i - 1][j] == Cases.caseNonEclaire.value) {
            possibilite[i - 1][j] = false;
          }
          if (i + 1 < matrice.length &&
              matrice[i + 1][j] == Cases.caseNonEclaire.value) {
            possibilite[i + 1][j] = false;
          }
          if (j - 1 >= 0 && matrice[i][j - 1] == Cases.caseNonEclaire.value) {
            possibilite[i][j - 1] = false;
          }
          if (j + 1 < matrice.length &&
              matrice[i][j + 1] == Cases.caseNonEclaire.value) {
            possibilite[i][j + 1] = false;
          }
        }
      }
    }
  }

  int nbVoisinsLibre(int i, int j) {
    int total = 0;
    if (i - 1 >= 0 && possibilite[i - 1][j]) {
      total++;
    }
    if (i + 1 < possibilite.length && possibilite[i + 1][j]) {
      total++;
    }
    if (j - 1 >= 0 && possibilite[i][j - 1]) {
      total++;
    }
    if (j + 1 < possibilite.length && possibilite[i][j + 1]) {
      total++;
    }
    return total;
  }

  int nbVoisinsAmpoule(int i, int j) {
    int total = 0;
    if (i - 1 >= 0 && matrice[i - 1][j] == Cases.ampoule.value) {
      total++;
    }
    if (i + 1 < matrice.length && matrice[i + 1][j] == Cases.ampoule.value) {
      total++;
    }
    if (j - 1 >= 0 && matrice[i][j - 1] == Cases.ampoule.value) {
      total++;
    }
    if (j + 1 < matrice.length && matrice[i][j + 1] == Cases.ampoule.value) {
      total++;
    }
    return total;
  }

  (int, int) nCellwithNVoisins() {
    for (var i = 0; i < matrice.length; i++) {
      for (var j = 0; j < matrice.length; j++) {
        switch (matrice[i][j]) {
          case 11:
            if ((nbVoisinsLibre(i, j) + nbVoisinsAmpoule(i, j)) == 1 &&
                nbVoisinsLibre(i, j) != 0) {
              return (i, j);
            }
            break;
          case 12:
            if ((nbVoisinsLibre(i, j) + nbVoisinsAmpoule(i, j)) == 2 &&
                nbVoisinsLibre(i, j) != 0) {
              return (i, j);
            }
            break;
          case 13:
            if ((nbVoisinsLibre(i, j) + nbVoisinsAmpoule(i, j)) == 3 &&
                nbVoisinsLibre(i, j) != 0) {
              return (i, j);
            }
            break;
          case 14:
            if ((nbVoisinsLibre(i, j) + nbVoisinsAmpoule(i, j)) == 4 &&
                nbVoisinsLibre(i, j) != 0) {
              return (i, j);
            }
            break;
          default:
        }
      }
    }
    return (-1, -1);
  }

  poserAmpoule(int iAmpoule, int jAmpoule) {
    matrice[iAmpoule][jAmpoule] = Cases.ampoule.value;
    possibilite[iAmpoule][jAmpoule] = false;
    var i = iAmpoule;
    var j = jAmpoule;
    i--;
    while (i >= 0 &&
        (matrice[i][j] == Cases.caseNonEclaire.value ||
            matrice[i][j] == Cases.caseEclaire.value)) {
      matrice[i][j] = Cases.caseEclaire.value;
      possibilite[i][j] = false;
      i--;
    }
    i = iAmpoule;
    i++;
    while (i < matrice.length &&
        (matrice[i][j] == Cases.caseNonEclaire.value ||
            matrice[i][j] == Cases.caseEclaire.value)) {
      matrice[i][j] = Cases.caseEclaire.value;
      possibilite[i][j] = false;
      i++;
    }
    i = iAmpoule;
    j--;
    while (j >= 0 &&
        (matrice[i][j] == Cases.caseNonEclaire.value ||
            matrice[i][j] == Cases.caseEclaire.value)) {
      matrice[i][j] = Cases.caseEclaire.value;
      possibilite[i][j] = false;
      j--;
    }
    j = jAmpoule;
    j++;
    while (j < matrice.length &&
        (matrice[i][j] == Cases.caseNonEclaire.value ||
            matrice[i][j] == Cases.caseEclaire.value)) {
      matrice[i][j] = Cases.caseEclaire.value;
      possibilite[i][j] = false;
      j++;
    }
    j = jAmpoule;
  }

  nCell(int i, int j) {
    if (i - 1 >= 0 && possibilite[i - 1][j]) {
      poserAmpoule(i - 1, j);
    }
    if (i + 1 < possibilite.length && possibilite[i + 1][j]) {
      poserAmpoule(i + 1, j);
    }
    if (j - 1 >= 0 && possibilite[i][j - 1]) {
      poserAmpoule(i, j - 1);
    }
    if (j + 1 < possibilite.length && possibilite[i][j + 1]) {
      poserAmpoule(i, j + 1);
    }
  }

  solve() {
    zerosCell();
    var (i, j) = nCellwithNVoisins();
    while (i != -1 && j != -1) {
      nCell(i, j);
      (i, j) = nCellwithNVoisins();
    }
  }
}
