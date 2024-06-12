import 'package:akari_project/mecaniques/models.dart';
import 'package:akari_project/mecaniques/generateur.dart';
import 'package:akari_project/mecaniques/solution.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'partie.g.dart';

@HiveType(typeId: 6)
class Partie {
  @HiveField(0)
  Grille _initial;
  @HiveField(1)
  late Grille puzzle;
  @HiveField(2)
  List<Grille> listeAction = [];
  @HiveField(3)
  int timer = 0;

  Partie()  : _initial = Grille.empty(0),
        puzzle = Grille.empty(0);

  Partie.newGame(int length) : _initial = Generateur().generateurComplet(length) {
    puzzle = Grille.copy(_initial);
  }

  Partie.fromGrille(this.puzzle) : _initial = puzzle;
//Fonction pour quand dans partie
  bool cliquerCase(int i, int j) {
    listeAction.add(Grille.copy(puzzle));
    if (puzzle.isCase(i, j, Cases.ampoule)) {
      puzzle.enleverAmpoule(i, j);
      puzzle.set(i, j, Cases.point);
    } else if (puzzle.isCase(i, j, Cases.ampouleRouge)) {
      puzzle.enleverAmpoule(i, j);
      puzzle.set(i, j, Cases.pointEclaire);
    } else if (puzzle.isCase(i, j, Cases.nonEclaire) ||
        puzzle.isCase(i, j, Cases.eclaire)) {
      puzzle.poserAmpoule(i, j);
    } else if (puzzle.isCase(i, j, Cases.pointEclaire)) {
      puzzle.set(i, j, Cases.eclaire);
    } else if (puzzle.isCase(i, j, Cases.point)) {
      puzzle.set(i, j, Cases.nonEclaire);
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

  void resoudre() async {
    List<Grille> solutions = Solveur().backtrackSolveur(_initial);
    if (solutions.isNotEmpty) {
      puzzle = Grille.copy(solutions[0]);
    }
  }

  bool indice() {
    var (int i, int j) = puzzle.indiceCase();
    if (i != -1 && j != -1) {
      listeAction.add(Grille.copy(puzzle));
      if (puzzle.isBulb(i, j)) {
        puzzle.enleverAmpoule(i, j);
      } else {
        puzzle.poserAmpoule(i, j);
      }
    }
    return puzzle.isSolved();
  }

  void afficherGrille() {
    puzzle.afficherMat();
  }
}
