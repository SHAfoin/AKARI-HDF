import 'dart:io';
import 'dart:math';

class Resolveur{
  final List<int> ligne;
  final List<List<int>> matrice;
  
  const Resolveur(this.ligne, this.matrice);



}
void afficherTruc(){
    print("Eekd");
  }
// valeur zone non éclairé = 0
// valeur zone éclairé = 1
// valeur ampoule = 5
// valeur mur = 6
final List<List<int>> matrice2 = [[0,0,6,0,0,0,0],[0,6,6,0,0,6,0],[0,0,0,6,6,0,0],[6,0,0,0,6,0,0],[6,6,6,0,0,0,0],[0,0,0,6,6,0,0],[0,0,0,0,0,6,6]];

List<List<int>> fillWithLight(final List<List<int>> matrice){
    int verif = 1;
    while(verif == 1){
      verif = 0;
      var random = Random();
      var num1 = random.nextInt(matrice.length);
      var num2 = random.nextInt(matrice[0].length);
      if(matrice[num1][num2] == 0){
        matrice[num1][num2] = 5;
        newBulb(num1, num2, matrice);
        for(int k = 0;k<matrice.length;k++){
          if(matrice[k].contains(0) == true){
            verif = 1;
            
        }
      }

      }
      else{
        verif = 1;
      }


    }

    print("Espace rempli !");
    return matrice;
  }


void newBulb(int a,int b,List<List<int>> matrice){
  int k = a - 1;
  int l = b - 1;
  int u = a + 1;
  int v = b + 1;
  while( (k >= 0 && matrice[k][b] == 0) || (k >= 0 && matrice[k][b] == 1)){
    matrice[k][b] = 1;
    k--;
  }
  while( (l >= 0 && matrice[a][l] == 0) || (l >= 0 && matrice[a][l] == 1)){
    matrice[a][l] = 1;
    l--;
  }

  while((u <= matrice.length -1 && matrice[u][b] == 0) || (u <= matrice.length - 1 && matrice[u][b] == 1)){
    matrice[u][b] = 1;
    u++;
  }
  while((v <= matrice[0].length - 1 && matrice[a][v] == 0) || (v <= matrice[0].length -1 && matrice[a][v] == 1) ){
    matrice[a][v] = 1;
    v++;
  }

}



void main(){
  List<List<int>> matrice = fillWithLight(matrice2);
  for(int i = 0;i<matrice.length;i++){
    print(matrice[i]);
  }
}

