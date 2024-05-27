import 'package:akari_project/mecaniques/models.dart';

class Solveur {
  void zerosCell(Grille puzzle) {
    for (var i = 0; i < puzzle.length; i++) {
      for (var j = 0; j < puzzle.length; j++) {
        if (puzzle.isCase(i, j, Cases.zeroCell)) {
          if (i - 1 >= 0 && puzzle.isCase(i - 1, j, Cases.nonEclaire)) {
            puzzle.removeCandidate(i - 1, j);
          }
          if (i + 1 < puzzle.length &&
              puzzle.isCase(i + 1, j, Cases.nonEclaire)) {
            puzzle.removeCandidate(i + 1, j);
          }
          if (j - 1 >= 0 && puzzle.isCase(i, j - 1, Cases.nonEclaire)) {
            puzzle.removeCandidate(i, j - 1);
          }
          if (j + 1 < puzzle.length &&
              puzzle.isCase(i, j + 1, Cases.nonEclaire)) {
            puzzle.removeCandidate(i, j + 1);
          }
        }
      }
    }
  }

  (int, int) nCellwithNVoisins(Grille puzzle) {
    for (var i = 0; i < puzzle.length; i++) {
      for (var j = 0; j < puzzle.length; j++) {
        switch (puzzle.get(i, j)) {
          case Cases.oneCell:
            if ((puzzle.nbVoisinsLibre(i, j) + puzzle.nbVoisinsAmpoule(i, j)) ==
                    1 &&
                puzzle.nbVoisinsLibre(i, j) != 0) {
              return (i, j);
            }
            break;
          case Cases.twoCell:
            if ((puzzle.nbVoisinsLibre(i, j) + puzzle.nbVoisinsAmpoule(i, j)) ==
                    2 &&
                puzzle.nbVoisinsLibre(i, j) != 0) {
              return (i, j);
            }
            break;
          case Cases.threeCell:
            if ((puzzle.nbVoisinsLibre(i, j) + puzzle.nbVoisinsAmpoule(i, j)) ==
                    3 &&
                puzzle.nbVoisinsLibre(i, j) != 0) {
              return (i, j);
            }
            break;
          case Cases.fourCell:
            if ((puzzle.nbVoisinsLibre(i, j) + puzzle.nbVoisinsAmpoule(i, j)) ==
                    4 &&
                puzzle.nbVoisinsLibre(i, j) != 0) {
              return (i, j);
            }
            break;
          default:
            break;
        }
      }
    }
    return (-1, -1);
  }

  void trivialSolveur(Grille puzzle) {
    zerosCell(puzzle);
    var (int i, int j) = nCellwithNVoisins(puzzle);
    while (i != -1 && j != -1) {
      puzzle.ampouleNCell(i, j);
      (i, j) = nCellwithNVoisins(puzzle);
    }
  }

  bool checkWallsFeasability(Grille puzzle) {
    for (var i = 0; i < puzzle.length; i++) {
      for (var j = 0; j < puzzle.length; j++) {
        switch (puzzle.get(i, j)) {
          case Cases.oneCell:
            if (puzzle.nbVoisinsAmpoule(i, j) > 1 &&
                (puzzle.nbVoisinsLibre(i, j) + puzzle.nbVoisinsAmpoule(i, j)) <
                    1) {
              return false;
            }
            break;
          case Cases.twoCell:
            if (puzzle.nbVoisinsAmpoule(i, j) > 2 &&
                (puzzle.nbVoisinsLibre(i, j) + puzzle.nbVoisinsAmpoule(i, j)) <
                    2) {
              return false;
            }
            break;
          case Cases.threeCell:
            if (puzzle.nbVoisinsAmpoule(i, j) > 3 &&
                (puzzle.nbVoisinsLibre(i, j) + puzzle.nbVoisinsAmpoule(i, j)) <
                    3) {
              return false;
            }
            break;
          case Cases.fourCell:
            if (puzzle.nbVoisinsAmpoule(i, j) > 4 &&
                (puzzle.nbVoisinsLibre(i, j) + puzzle.nbVoisinsAmpoule(i, j)) <
                    4) {
              return false;
            }
            break;
          default:
            break;
        }
      }
    }
    return true;
  }

  bool backtracking(Grille puzzle, List<Grille> solutions) {
    if (puzzle.isSolved()) {
      solutions.add(puzzle);
      return true;
    }
    var (int i, int j) = puzzle.nextCandidate();
    if (!checkWallsFeasability(puzzle) ||
        (i == -1 || j == -1) ||
        puzzle.hasRedBulb()) {
      return false;
    }
    Grille copyAmpoule = Grille.copy(puzzle);
    copyAmpoule.poserAmpoule(i, j);
    if (backtracking(copyAmpoule, solutions)) {
      return true;
    } else {
      Grille copySansAmpoule = Grille.copy(puzzle);
      copySansAmpoule.removeCandidate(i, j);
      return backtracking(copySansAmpoule, solutions);
    }
  }

  List<Grille> backtrackSolveur(Grille puzzle) {
    Grille copy = Grille.copy(puzzle);
    trivialSolveur(copy);
    List<Grille> solutions = List<Grille>.empty(growable: true);
    backtracking(copy, solutions);
    return solutions;
  }
}
