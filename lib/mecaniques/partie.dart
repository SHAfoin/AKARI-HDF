import 'package:akari_project/models.dart';
import 'package:akari_project/solution.dart';

class Partie {
  Grille _initial;
  Grille puzzle;
  List<Grille> listeAction = [];
  int timer = 0;

  Partie(this.puzzle) : _initial = Grille.copy(puzzle);
//Fonction pour quand dans partie
  void cliquerCase(int i, int j) {
    listeAction.add(Grille.copy(puzzle));
    if (puzzle.isCase(i, j, Cases.nonEclaire)) {
      puzzle.set(i, j, Cases.point);
    } else if (puzzle.isCase(i, j, Cases.eclaire)) {
      puzzle.set(i, j, Cases.pointEclaire);
    } else if (puzzle.isCase(i, j, Cases.point) ||
        puzzle.isCase(i, j, Cases.pointEclaire)) {
      puzzle.poserAmpoule(i, j);
    } else if (puzzle.isCase(i, j, Cases.ampoule) ||
        puzzle.isCase(i, j, Cases.ampouleRouge)) {
      puzzle.enleverAmpoule(i, j);
    }
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
    
  }

  void afficherGrille() {
    puzzle.afficherMat();
  }
}
