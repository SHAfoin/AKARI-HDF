import 'dart:math';

import 'package:akari_project/models.dart';
import 'package:akari_project/resolveur.dart';
import 'package:akari_project/solution.dart';

class Indice{
  bool isSolvable(Grille grille){
    var solveur = Solveur();
    List<Grille> solutions = solveur.backtrackSolveur(grille);
    if(solutions.isEmpty){
      return false; 
    }
    return true;
  }

  List<List<int>> positionAmpoule(Grille grille){
    List<List<int>> listeAmpoule = [];
    for(int i = 0;i<grille.length;i++){
      for(int j = 0;j<grille.length;j++){
        if(grille.isCase(i, j, Cases.ampoule) || (grille.isCase(i, j, Cases.ampouleRouge))){
          listeAmpoule.add([i,j]);
        }
      }
    }
  return listeAmpoule;
  }
  
    
  void indiceCase(Grille grille,Partie partie){
    var solveur = Solveur();
    if(!isSolvable(grille)){
      List<Grille> listeSolution = solveur.backtrackSolveur(grille);
      var rand = Random();
      var quelNum = rand.nextInt(listeSolution.length);
      Grille grilleIndice = listeSolution[quelNum];
      grilleIndice.afficherMat();
      for(int i =0;i<grilleIndice.length;i++){
        for(int j =0;j<grilleIndice.length;j++){
          if((grilleIndice.isCase(i, j,Cases.ampoule) && !grille.isCase(i, j, Cases.ampoule)) || grilleIndice.isCase(i, j,Cases.ampoule) && !grille.isCase(i, j, Cases.ampouleRouge)){
            partie.cliquerCase(i, j);
            return;
          }
        }
      }
    }
    else {
      for(int i = 0;i<grille.length;i++){
        for(int j = 0;j<grille.length;j++){
          if(grille.isCase(i, j, Cases.ampouleRouge)){
            Grille nouvGrille = Grille.copy(grille);
            nouvGrille.enleverAmpoule(i, j);
            if(isSolvable(nouvGrille)){
              grille.enleverAmpoule(i, j);
              indiceCase(grille, partie);
            }
          }
        }
      }

      for(int i = 0 ; i < grille.length;i++){
        for(int j = 0 ; j < grille.length;j++){
          if(grille.isCase(i, j, Cases.ampoule)){
            Grille nouvGrille = Grille.copy(grille);
            if(isSolvable(nouvGrille)){
              grille.enleverAmpoule(i, j);
              indiceCase(grille,partie);
            }
          }
        }
      }
    }
    
    
    return;
  }


}




void main(){
final List<List<int>> matrice1 = [
  [0, 0, 6, 0, 0, 0, 0],
  [0, 11, 10, 0, 0, 6, 0],
  [0, 0, 0, 6, 6, 0, 11],
  [10, 0, 0, 0, 11, 0, 0],
  [6, 6, 11, 0, 0, 0, 0],
  [0, 0, 0, 10, 6, 0, 0],
  [6, 0, 0, 0, 0, 6, 10]
];



  Grille puzzle = Grille(matrice1);
  Partie partie = Partie(puzzle);
  partie.cliquerCase(0, 0);
  partie.cliquerCase(0, 0);

  partie.cliquerCase(1, 0);
  partie.cliquerCase(1, 0);
  Indice indice = Indice();
  indice.indiceCase(puzzle,partie);
}