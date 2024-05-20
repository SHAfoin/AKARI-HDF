import 'dart:math';

import 'package:akari_project/resolveur.dart';

enum Cases {
  nonEclaire(0),
  eclaire(1),
  ampoule(5),
  mur(6),
  ampouleRouge(9),
  zeroCell(10),
  oneCell(11),
  twoCell(12),
  threeCell(13),
  fourCell(14),
  point(99),
  other(-1);

  final int value;
  const Cases(this.value);

  static Cases getCase(int value) {
    switch (value) {
      case 0:
        return Cases.nonEclaire;
      case 1:
        return Cases.eclaire;
      case 5:
        return Cases.ampoule;
      case 6:
        return Cases.mur;
      case 9:
        return Cases.ampouleRouge;
      case 10:
        return Cases.zeroCell;
      case 11:
        return Cases.oneCell;
      case 12:
        return Cases.twoCell;
      case 13:
        return Cases.threeCell;
      case 14:
        return Cases.fourCell;
      case 99:
        return Cases.point;
      default:
        return Cases.other;
    }
  }
}

class Grille {
  final int length;
  final List<List<Cases>> _matrice;
  final List<List<bool>> _candidats;

  Grille(List<List<int>> matriceInt)
      : length = matriceInt.length,
        _matrice = List<List<Cases>>.generate(
            matriceInt.length,
            (i) => List<Cases>.generate(
                matriceInt.length, (j) => Cases.getCase(matriceInt[i][j]))),
        _candidats = List<List<bool>>.generate(
            matriceInt.length,
            (i) => List<bool>.generate(matriceInt.length,
                (j) => matriceInt[i][j] == Cases.nonEclaire.value));

  Grille.copy(Grille original)
      : length = original.length,
        _matrice = List<List<Cases>>.generate(
            original.length,
            (i) => List<Cases>.generate(
                original.length, (j) => original.get(i, j))),
        _candidats = List<List<bool>>.generate(
            original.length,
            (i) => List<bool>.generate(
                original.length, (j) => original.isCandidate(i, j)));

  Grille.empty(this.length)
      : _matrice = List<List<Cases>>.generate(length,
            (i) => List<Cases>.generate(length, (j) => Cases.nonEclaire)),
        _candidats = List<List<bool>>.generate(
            length, (i) => List<bool>.generate(length, (j) => true));

  Grille.onlyWalls(Grille original)
      : length = original.length,
        _matrice = List<List<Cases>>.generate(
            original.length,
            (i) => List<Cases>.generate(
                original.length,
                (j) => (!original.isWall(i, j))
                    ? Cases.nonEclaire
                    : original.get(i, j))),
        _candidats = List<List<bool>>.generate(
            original.length,
            (i) => List<bool>.generate(
                original.length, (j) => !original.isWall(i, j)));

  void afficherMat() {
    for (var i = 0; i < length; i++) {
      String line = "";
      for (var j = 0; j < length; j++) {
        switch (get(i, j)) {
          case Cases.eclaire:
            line += "o";
            break;
          case Cases.nonEclaire:
            line += " ";
            break;
          case Cases.ampoule:
            line += "@";
            break;
          case Cases.ampouleRouge:
            line += "!";
            break;
          case Cases.mur:
            line += "X";
            break;
          case Cases.zeroCell:
            line += "0";
            break;
          case Cases.oneCell:
            line += "1";
            break;
          case Cases.twoCell:
            line += "2";
            break;
          case Cases.threeCell:
            line += "3";
            break;
          case Cases.fourCell:
            line += "4";
            break;
          case Cases.point:
            line += "*";
            break;
          case Cases.other:
            line += "?";
            break;
        }
      }
      print(line);
    }
  }

  void afficherCandidats() {
    for (var i = 0; i < length; i++) {
      print(_candidats[i]);
    }
  }

  Cases get(int i, int j) {
    return _matrice[i][j];
  }

  void set(int i, int j, Cases value) {
    _matrice[i][j] = value;
    switch (value) {
      case Cases.mur:
      case Cases.zeroCell:
      case Cases.oneCell:
      case Cases.twoCell:
      case Cases.threeCell:
      case Cases.fourCell:
      case Cases.ampoule:
      case Cases.ampouleRouge:
      case Cases.eclaire:
        removeCandidate(i, j);
        break;
      case Cases.nonEclaire:
        addCandidate(i, j);
        break;
      case Cases.other:
      case Cases.point:
        break;
    }
  }

  bool isCase(int i, int j, Cases value) {
    return _matrice[i][j] == value;
  }

  bool isWall(int i, int j) {
    return isCase(i, j, Cases.mur) ||
        isCase(i, j, Cases.oneCell) ||
        isCase(i, j, Cases.twoCell) ||
        isCase(i, j, Cases.threeCell) ||
        isCase(i, j, Cases.fourCell);
  }

  bool isCandidate(int i, int j) {
    return _candidats[i][j];
  }

  void removeCandidate(int i, int j) {
    _candidats[i][j] = false;
  }

  void addCandidate(int i, int j) {
    _candidats[i][j] = true;
  }

  int nbVoisinsLibre(int i, int j) {
    int total = 0;
    if (i - 1 >= 0 && isCandidate(i - 1, j)) {
      total++;
    }
    if (i + 1 < length && isCandidate(i + 1, j)) {
      total++;
    }
    if (j - 1 >= 0 && isCandidate(i, j - 1)) {
      total++;
    }
    if (j + 1 < length && isCandidate(i, j + 1)) {
      total++;
    }
    return total;
  }

  int nbVoisinsAmpoule(int i, int j) {
    int total = 0;
    if (i - 1 >= 0 && isCase(i - 1, j, Cases.ampoule)) {
      total++;
    }
    if (i + 1 < length && isCase(i + 1, j, Cases.ampoule)) {
      total++;
    }
    if (j - 1 >= 0 && isCase(i, j - 1, Cases.ampoule)) {
      total++;
    }
    if (j + 1 < length && isCase(i, j + 1, Cases.ampoule)) {
      total++;
    }
    return total;
  }

  void poserAmpoule(int i, int j) {
    set(i, j,
        isCase(i, j, Cases.nonEclaire) ? Cases.ampoule : Cases.ampouleRouge);
    eclairer(i, j);
  }

  void eclairer(int iAmpoule, int jAmpoule) {
    int i = iAmpoule;
    int j = jAmpoule;
    i--;
    while (i >= 0 && !isWall(i, j)) {
      if (!isCase(i, j, Cases.ampoule) && !isCase(i, j, Cases.ampouleRouge)) {
        set(i, j, Cases.eclaire);
      } else {
        set(i, j, Cases.ampouleRouge);
      }
      i--;
    }
    i = iAmpoule;
    i++;
    while (i < length && !isWall(i, j)) {
      if (!isCase(i, j, Cases.ampoule) && !isCase(i, j, Cases.ampouleRouge)) {
        set(i, j, Cases.eclaire);
      } else {
        set(i, j, Cases.ampouleRouge);
      }
      i++;
    }
    i = iAmpoule;
    j--;
    while (j >= 0 && !isWall(i, j)) {
      if (!isCase(i, j, Cases.ampoule) && !isCase(i, j, Cases.ampouleRouge)) {
        set(i, j, Cases.eclaire);
      } else {
        set(i, j, Cases.ampouleRouge);
      }
      j--;
    }
    j = jAmpoule;
    j++;
    while (j < length && !isWall(i, j)) {
      if (!isCase(i, j, Cases.ampoule) && !isCase(i, j, Cases.ampouleRouge)) {
        set(i, j, Cases.eclaire);
      } else {
        set(i, j, Cases.ampouleRouge);
      }
      j++;
    }
    j = jAmpoule;
  }

  void ampouleNCell(int i, int j) {
    if (i - 1 >= 0 && isCandidate(i - 1, j)) {
      poserAmpoule(i - 1, j);
    }
    if (i + 1 < length && isCandidate(i + 1, j)) {
      poserAmpoule(i + 1, j);
    }
    if (j - 1 >= 0 && isCandidate(i, j - 1)) {
      poserAmpoule(i, j - 1);
    }
    if (j + 1 < length && isCandidate(i, j + 1)) {
      poserAmpoule(i, j + 1);
    }
  }

  (int, int) nextCandidate() {
    for (var i = 0; i < length; i++) {
      for (var j = 0; j < length; j++) {
        if (isCandidate(i, j)) {
          return (i, j);
        }
      }
    }
    return (-1, -1);
  }

  void _enleverLumiere() {
    for (var i = 0; i < length; i++) {
      for (var j = 0; j < length; j++) {
        if (isCase(i, j, Cases.eclaire)) {
          set(i, j, Cases.nonEclaire);
        } else if (isCase(i, j, Cases.ampouleRouge)) {
          set(i, j, Cases.ampoule);
        }
      }
    }
  }

  void enleverAmpoule(int iAmpoule, int jAmpoule) {
    _enleverLumiere();
    set(iAmpoule, jAmpoule, Cases.nonEclaire);
    for (int i = 0; i < length; i++) {
      for (int j = 0; j < length; j++) {
        if (isCase(i, j, Cases.ampoule)) {
          eclairer(i, j);
        }
      }
    }
  }
}
