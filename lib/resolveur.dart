import 'dart:io';
import 'dart:math';

// Valeur a changer potentiellement 
int mur = 6;
int caseEclaire = 1;
int caseNonEclaire = 0;
int ampoule = 5;

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
final List<List<int>> matrice2 = [[0,0,6,0,0,0,0],[0,6,6,0,0,6,0],[0,0,0,6,6,0,6],[6,0,0,0,6,0,0],[6,6,6,0,0,0,0],[0,0,0,6,6,0,0],[6,0,0,0,0,6,6]];
final List<List<int>> matrice3 = [[0,0,6,0,0,0,0],[0,6,6,0,0,6,0],[0,0,0,6,6,0,6]];
final List<List<int>> matrice4 = [[0,0,6,0],[0,6,6,0],[0,0,0,6],[0,0,0,6],[6,0,0,6]];


List<List<int>> fillWithLight(final List<List<int>> matrice){
    int verif = 1;
    while(verif == 1){
      verif = 0;
      var random = Random();
      var num1 = random.nextInt(matrice.length);
      var num2 = random.nextInt(matrice[0].length);
      if(matrice[num1][num2] == caseNonEclaire){
        matrice[num1][num2] = ampoule;
        newBulb(num1, num2, matrice);
        for(int k = 0;k<matrice.length;k++){
          if(matrice[k].contains(caseNonEclaire) == true){
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
  while( (k >= 0 && matrice[k][b] == caseNonEclaire) || (k >= 0 && matrice[k][b] == caseEclaire)){
    matrice[k][b] = 1;
    k--;
  }
  while( (l >= 0 && matrice[a][l] == caseNonEclaire) || (l >= 0 && matrice[a][l] == caseEclaire)){
    matrice[a][l] = 1;
    l--;
  }

  while((u <= matrice.length -1 && matrice[u][b] == caseNonEclaire) || (u <= matrice.length - 1 && matrice[u][b] == caseEclaire)){
    matrice[u][b] = 1;
    u++;
  }
  while((v <= matrice[0].length - 1 && matrice[a][v] == caseNonEclaire) || (v <= matrice[0].length -1 && matrice[a][v] == caseEclaire) ){
    matrice[a][v] = 1;
    v++;
  }

}


// Cette fonction absolument dégeulasse numérote pour chaque mur le nombre d'ampoule qui lui est adjacente
// On regarde chaque case, et comme on est dans une liste, on est obligé de distingué les cas où on est au bord
// dans un coin, ou non
void afficherMat(List<List<int>> matrice){
    for(int i = 0;i<matrice.length;i++){
    print(matrice[i]);
  }
}

List<List<int>> putNumberOnWalls(List<List<int>> mat){
  int long = mat.length;
  int larg = mat[0].length;
  

  List<List<int>> mat2 = [];
  for(int k = 0;k<long + 2;k++){
    mat2.add([0]);
  }
  
  

  for(int i = 0;i<larg+1;i++){
    mat2[0].add(0);
    mat2[long+1].add(0);
  }
  

  for(int j = 1;j<long+1;j++){
    for(int l = 0;l<larg;l++){
      mat2[j].add(mat[j-1][l]);
    }
  }
  

  for(int m =1;m<long + 1;m++){
    mat2[m].add(0);
  }

  for(int k = 0; k<long;k++){
    for(int i =0;i<larg;i++){
      int compteur = 0;
      List<int> list2 = [i,i,i-1,i+1];
      List<int> list1 = [k+1,k-1,k,k];
      if(mat[k][i] == mur){
        for(int j = 0;j<4;j++){
          if(mat2[list1[j] + 1][list2[j] + 1] == ampoule){
            compteur++;
            }
          String val = ('1' + compteur.toString());
          mat[k][i] = int.parse(val);
        }
      }
    }
  }
  return mat;
}

// On a que soit des murs numérotés, soit des cases éclairés, soit des ampoules
// On regarde donc si on est pas sur une case éclairé ou une ampoule
List<List<int>> retirerNmAlea(List<List<int>> matrice){

  double p = 500;
  print("");
  afficherMat(matrice);
  print("");
  for(int k = 0;k<matrice.length;k++){
    for(int i = 0;i<matrice[0].length;i++){
      print(matrice[k][i]);
      if((matrice[k][i] != caseEclaire) && (matrice[k][i] != ampoule)){
        var nombreAlea = Random().nextInt(1000);
        
        if(nombreAlea > p){
          matrice[k][i] = 6;
        }
      }
    }
  }
  return matrice; 
}

void main(){
  List<List<int>> matrice = fillWithLight(matrice4);
  for(int i = 0;i<matrice.length;i++){
    print(matrice[i]);
  }
  matrice = putNumberOnWalls(matrice);
  afficherMat(matrice);
  matrice = retirerNmAlea(matrice);
  afficherMat(matrice);

}

