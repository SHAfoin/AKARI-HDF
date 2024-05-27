import 'package:akari_project/mecaniques/models.dart';
import 'package:akari_project/mecaniques/generateur.dart';
import 'package:akari_project/mecaniques/solution.dart';

class Partie {
  final Grille _initial;
  late Grille puzzle;
  List<Grille> listeAction = [];
  int timer = 0;

  Partie(int length) : _initial = Generateur().generateurComplet(length) {
    puzzle = Grille.copy(_initial);
  }

  Partie.fromGrille(this.puzzle) : _initial = puzzle;
//Fonction pour quand dans partie
  bool cliquerCase(int i, int j) {
    listeAction.add(Grille.copy(puzzle));
    if (puzzle.isCase(i, j, Cases.nonEclaire)) {
      puzzle.set(i, j, Cases.point);
    } else if (puzzle.isCase(i, j, Cases.eclaire)) {
      puzzle.set(i, j, Cases.pointEclaire);
    } else if (puzzle.isPoint(i, j)) {
      puzzle.poserAmpoule(i, j);
    } else if (puzzle.isBulb(i, j)) {
      puzzle.enleverAmpoule(i, j);
    }
    return puzzle.isSolved();
  }

  void reset() {
    listeAction.clear();
    puzzle = Grille.copy(_initial);
  }

  void annuler() {
    if (listeAction.isNotEmpty) {
      puzzle = listeAction.removeLast();
    }
  }

  void resoudre() {
    List<Grille> solutions = Solveur().backtrackSolveur(_initial);
    if (solutions.isNotEmpty) {
      puzzle = Grille.copy(solutions[0]);
    }
  }

  void indice() {
    var (int i, int j) = puzzle.indiceCase();
    if (i != -1 && j != -1) {
      listeAction.add(Grille.copy(puzzle));
      if (puzzle.isBulb(i, j)) {
        puzzle.enleverAmpoule(i, j);
      } else {
        puzzle.poserAmpoule(i, j);
      }
    }
  }

  void afficherGrille() {
    puzzle.afficherMat();
  }
}
