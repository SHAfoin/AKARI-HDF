import 'package:akari_project/models.dart';
import 'package:akari_project/solution.dart';
import 'package:flutter/material.dart';

void main() {
  final List<List<int>> matrice1 = [[0,12,0,10,0,0,0],[0,0,0,11,0,0,10],[0,0,0,0,0,0,0],[11,10,0,0,0,6,6],[0,0,0,0,0,0,0],[11,0,0,10,0,0,0],[0,0,0,6,0,12,0]];
  final List<List<int>> matrice2 = [[0,0,0,0,6,0,0],[0,0,13,0,0,0,0],[12,0,0,14,0,6,0],[0,0,6,0,6,0,0],[0,6,0,6,0,0,11],[0,0,0,0,13,0,0],[0,0,10,0,0,0,0]];
  var solv = Solveur();
  Grille puzzle = Grille(matrice1.length, matrice1);
  List<Grille> solutions = solv.backtrackSolveur(puzzle);
  for (var grille in solutions) {
    grille.afficherMat();
  }
  // runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child:Text('Hello World!'),
        ),
      ),
    );
  }
}
