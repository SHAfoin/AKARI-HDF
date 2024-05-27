import 'dart:math';

import 'package:akari_project/mecaniques/partie.dart';
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
