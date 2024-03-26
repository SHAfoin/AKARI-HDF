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
  
  for(int k = 0;k<long;k++){
    int compteur = 0;
    if(k == 0){
      
      //premier cas
      if(mat[0][0] == mur){
        if(mat[0][1] == ampoule){
          compteur++;
        }
        if(mat[1][0] == ampoule){
          compteur++;
        }
        String val = ('1' + compteur.toString());
        mat[0][0] = int.parse(val);
      }
      // On fait la première ligne sans les coins 
      for(int i = 1;i<mat[0].length -1;i++){
        if(mat[0][i]==mur){
          compteur = 0;
          if(mat[0][i-1] == ampoule){
            compteur++;
          }
          if(mat[0][i+1] == ampoule){
            compteur++;
          }
          if(mat[1][i] == ampoule){
            compteur++;
          }
          String val = ('1' + compteur.toString());
          mat[k][i] = int.parse(val);
          }
      }
      // l'autre coin
      if(mat[0][larg - 1] == mur){
        compteur = 0;
        if(mat[0][larg - 2] == ampoule){
          compteur++;
        }
        if(mat[1][larg - 1] == ampoule){
          compteur++;
        }
        String val = ('1' + compteur.toString());
        mat[0][larg-1] = int.parse(val);
      }
    }
    else if(k == long - 1){
        if(mat[long -1][0] == mur){
          compteur = 0;
          if(mat[long-1][1] == ampoule){
            compteur++;
          }
          if(mat[long-2][0] == ampoule){
            compteur++;
        }
        String val = ('1' + compteur.toString());
        mat[long -1][0] = int.parse(val);
        }

        if(mat[long-1][larg-1] == mur){
          compteur = 0;
          if(mat[long-2][larg-1] == ampoule){
            compteur++;
          }
          if(mat[long-1][larg-2] == ampoule){
            compteur++;
          }
          String val = ('1' + compteur.toString());
          mat[long -1][larg-1] = int.parse(val);
        }
        for(int i = 1;i<larg-1;i++){
          
          if(mat[long-1][i] == mur){
            compteur = 0;
            if(mat[long-1][i-1] == ampoule){
              compteur++;
            }
            if(mat[long-1][i+1] == ampoule){
              compteur++;
            }
            if(mat[long-2][i] == ampoule){
              compteur++;
            }  
            String val = ('1' + compteur.toString());
            mat[long -1][i] = int.parse(val);
          }
        }
      }
      else{
        if(mat[k][0] == mur){
          compteur = 0;
          if(mat[k+1][0] == ampoule){
            compteur++;
          }
          if(mat[k-1][0] == ampoule){
            compteur++;
          }
          if(mat[k][1] == ampoule){
            compteur++;
          }
          String val = ('1' + compteur.toString());
          mat[k][0] = int.parse(val);
        }
        if(mat[k][larg-1] == mur){
          compteur = 0;
          if(mat[k+1][larg-1]== ampoule){
            compteur++;
          }
          if(mat[k-1][larg-1] == ampoule){
            compteur++;
          }
          if(mat[k][larg-2] == ampoule){
            compteur++;
          }
          String val = ('1' + compteur.toString());
          mat[k][larg-1] = int.parse(val);
        }
        for(int i = 1;i<larg-1;i++){
          compteur = 0;
          List<int> list2 = [i,i,i-1,i+1];
          List<int> list1 = [k+1,k-1,k,k];
          if(mat[k][i] == mur){
            for(int j = 0;j<4;j++){
              if(mat[list1[j]][list2[j]] == ampoule){
                compteur++;
              }
              String val = ('1' + compteur.toString());
              mat[k][i] = int.parse(val);
            }
          }
        }
      }

 
  }
  print("");
  afficherMat(mat);
  return mat;
}

void main(){
  List<List<int>> matrice = fillWithLight(matrice2);
  for(int i = 0;i<matrice.length;i++){
    print(matrice[i]);
  }
  putNumberOnWalls(matrice);

}

