import 'dart:math';

// Valeur a changer potentiellement 
int mur = 6;
int caseEclaire = 1;
int caseNonEclaire = 0;
int ampoule = 5;
//Ampoule rouge = ampoule déjà sur une ligne
int ampouleRouge = 9;
int point = 99;

List<List<int>> listeAction = [];

//Ceci va aider quand à la réalisation de MAIS BORDEL LA CASE EST ECLAIRE OU NON
//En premier on aura ligne puis colonne
List<List<int>> listeEmplacementAmpoule =[];



class Resolveur{
  final List<int> ligne;
  final List<List<int>> matrice;
  const Resolveur(this.ligne, this.matrice);
}
// valeur zone non éclairé = 0
// valeur zone éclairé = 1
// valeur ampoule = 5
// valeur mur = 6
final List<List<int>> matrice2 = [[0,0,6,0,0,0,0],[0,6,6,0,0,6,0],[0,0,0,6,6,0,6],[6,0,0,0,6,0,0],[6,6,6,0,0,0,0],[0,0,0,6,6,0,0],[6,0,0,0,0,6,6]];
final List<List<int>> matrice3 = [[0,0,6,0,0,0,0],[0,6,6,0,0,6,0],[0,0,0,6,6,0,6]];
final List<List<int>> matrice4 = [[0,0,6,0],[0,6,6,0],[0,0,0,6],[0,0,0,6],[6,0,0,6]];

//Création de la matrice

List<List<int>> creationMatrice(int l){
  List<List<int>> mat = [];
  for(int i = 0;i < l;i++){
    List<int> ligne = []; 
    for (int ii = 0; ii < l; ii++){
      var random = Random();
      var num1 = random.nextInt(100);
      (num1 < 21 ) ? ligne.add(mur) : ligne.add(caseNonEclaire);
    }
    mat.add(ligne);
  }
  return mat;
}

//Fonction qui ajoute des ampoules de manière aléatoire pour afficher les nombres sur les murs
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
    return matrice;
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
          String val = ('1$compteur');
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
  for(int k = 0;k<matrice.length;k++){
    for(int i = 0;i<matrice[0].length;i++){
      
      if((matrice[k][i] != caseEclaire) && (matrice[k][i] != ampoule)){
        var nombreAlea = Random().nextInt(1000);
        
        if(nombreAlea > p){
          matrice[k][i] = mur;
        }
      }
    }
  }
  return matrice; 
}


List<List<int>> onlyWalls(List<List<int>> matrice){
    List<List<int>> matriceRetour = [];
    for(int k = 0; k<matrice.length;k++){
      List<int> ligne = []; 
      for (int i = 0; i < matrice[0].length;i++){
        (matrice[k][i] == ampoule || matrice[k][i] == caseEclaire ) ? ligne.add(caseNonEclaire) :  ligne.add(matrice[k][i]); 
      }
      matriceRetour.add(ligne);
    }
    return matriceRetour;
  }

//Fonction pour quand dans partie
void cliquerCase(List<List<int>> mat,int k,int i){
  //On regarde si c'est une case vide, un point ou une ampoule
  listeAction.add([k,i]);
  if(mat[k][i] == caseNonEclaire || mat[k][i] == caseEclaire){
    cliquerCasePoint(mat, k, i);
  }
  else if(mat[k][i] == point){
    rougeOuNon(mat, k, i);
    cliquerCaseAmpoule(mat, k, i);

  }
  else if(mat[k][i] == ampoule || mat[k][i] == ampouleRouge) {
    enleverAmpoule(mat, k, i);
    checherAutreAmpoule(mat,listeEmplacementAmpoule);
  }
  else{
    
  }

}

void checherAutreAmpoule(List<List<int>> matrice,List<List<int>> ampouleListe){
  for(int k = 0;k<ampouleListe.length;k++){
    rougeOuNon(matrice, ampouleListe[k][0], ampouleListe[k][1]);
  }
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

void cliquerCaseAmpoule(List<List<int>> mat, int k, int i){
  // On suppose que c'est pas déja cliqué
  listeEmplacementAmpoule.add([k,i]);
  if((mat[k][i] == caseNonEclaire) || (mat[k][i] == ampoule)){
    mat[k][i] = ampoule;
    newBulb(k, i, mat);
  }
  if((mat[k][i] == caseEclaire) || (mat[k][i] == ampouleRouge)){
    mat[k][i] = ampouleRouge;
    newBulb(k, i, mat);
  }
}

//On appelle cette fonction quand on passe de ampoule à rien ou de point à ampoule, pour savoir si on
//doit mettre une ampoule normale ou une ampoule rouge
void rougeOuNon(List<List<int>> matrice,int a,int b){
  matrice[a][b] = ampoule;
  int k = a - 1; //-1
  int l = b - 1; //-1
  int u = a + 1; //+1
  int v = b + 1; //+1
  while((k >= 0 && matrice[k][b] == caseEclaire) || (k >= 0 && matrice[k][b] == ampoule) || (k >= 0 && matrice[k][b] == ampoule)){
    if(matrice[k][b] == ampoule || matrice[k][b] == ampouleRouge){
      matrice[k][b] = ampouleRouge;
      matrice[a][b] = ampouleRouge;
    }
    k--;
  }
  while((l >= 0 && matrice[a][l] == caseEclaire) || (l >= 0 && matrice[a][l] == ampoule) || (l >= 0 && matrice[a][l] == ampouleRouge)){
    if(matrice[a][l] == ampoule || matrice[a][l] == ampouleRouge){
      matrice[a][l] = ampouleRouge;
      matrice[a][b] = ampouleRouge;
    }
    l--;
  }

  while((u <= matrice.length - 1 && matrice[u][b] == caseEclaire) || (u <= matrice.length - 1 &&  matrice[u][b] == ampoule) || (u <= matrice.length - 1 &&  matrice[u][b] == ampouleRouge)){
    if(matrice[u][b] == ampoule || matrice[u][b] == ampouleRouge){
      matrice[u][b] = ampouleRouge;
      matrice[a][b] = ampouleRouge;
    }
    u++;
  }
  while((v <= matrice[0].length -1 && matrice[a][v] == caseEclaire) || (v <= matrice[0].length -1 && matrice[a][v] == ampoule) || (v <= matrice[0].length -1 && matrice[a][v] == ampouleRouge)){
    if(matrice[a][v] == ampoule || matrice[a][v] == ampouleRouge){
      matrice[a][v] = ampouleRouge;
      matrice[a][b] = ampouleRouge;
    }
    v++;
  }
}

void annuler(List<List<int>> listeAction,List<List<int>> mat){
  
  int k = listeAction[listeAction.length - 1][0];
  int i = listeAction[listeAction.length - 1][1];
  cliquerCase(mat, k, i);
  cliquerCase(mat, k, i);
  for(int j = 0;j<3;j++){
    
    listeAction.removeAt(listeAction.length -1);
  }
}

void cliquerCasePoint(List<List<int>> mat, int k, int i){
  // On suppose que c'est pas déja cliqué
  
  if(mat[k][i] == caseNonEclaire || mat[k][i] == caseEclaire){
    mat[k][i] = point;
  }
}

bool ampouleOuNon(List<List<int>> matrice,List<List<int>> emplacementAmpoule,int k, int i){

  for(int j = 0;j<emplacementAmpoule.length;j++){
    if(k == emplacementAmpoule[j][0]){
      for(int a = min(i,emplacementAmpoule[j][1]);a <= max(i,emplacementAmpoule[j][1]);a++){

        if(matrice[k][a] == mur || matrice[k][a] == 10 || matrice[k][a] == 11 || matrice[k][a] == 12 || matrice[k][a] == 13 || matrice[k][a] == 14){
          return false;
        }
        else if(matrice[k][a] == ampoule || matrice[k][a] == ampouleRouge){
          return true;
        }
      }
    }
    if(i == emplacementAmpoule[j][1]){
      for(int a = min(k,emplacementAmpoule[j][0]);a <= max(k,emplacementAmpoule[j][0]);a++){
        if(matrice[a][i] == mur || matrice[a][i] == 10 || matrice[a][i] == 11 || matrice[a][i] == 12 || matrice[a][i] == 13 || matrice[a][i] == 14){
          return false;
        }
        else if(matrice[a][i] == ampoule || matrice[a][i] == ampouleRouge){
          return true;
        }
      }
    }
  }
  
  return false;
}

void enleverAmpoule(List<List<int>> matrice,int a,int b){
  suppElemListe(listeEmplacementAmpoule,a,b);
 
  matrice[a][b] = caseNonEclaire;
  if(ampouleOuNon(matrice, listeEmplacementAmpoule, a, b)){
    matrice[a][b] = caseEclaire;
  }
  else{
    matrice[a][b] = caseNonEclaire;
  }
  int k = a - 1; //-1
  int l = b - 1; //-1
  int u = a + 1; //+1
  int v = b + 1; //+1

  while(k >= 0 && matrice[k][b] == caseEclaire){
    if(ampouleOuNon(matrice, listeEmplacementAmpoule, k, b)){
      matrice[k][b] = caseEclaire;
      
    }
    else{
      matrice[k][b] = caseNonEclaire;
    }
    k--;
  }
  while(l >= 0 && matrice[a][l] == caseEclaire){
    if(ampouleOuNon(matrice, listeEmplacementAmpoule, a, l)){
      matrice[a][l] = caseEclaire;
      
    }
    else{
      matrice[a][l] = caseNonEclaire;
    }
    l--;
  }

  while(u <= matrice.length - 1 && matrice[u][b] == caseEclaire ){
    if(ampouleOuNon(matrice, listeEmplacementAmpoule, u, b)){
      matrice[u][b] = caseEclaire;
      
    }
    else{
      matrice[u][b] = caseNonEclaire;
    }
    u++;
  }

  while(v <= matrice[0].length -1 && matrice[a][v] == caseEclaire){
    
    if(ampouleOuNon(matrice, listeEmplacementAmpoule, a, v)){
      matrice[a][v] = caseEclaire;
      
    }
    else{
      matrice[a][v] = caseNonEclaire;
    }
    v++;
  
  }
}

void suppElemListe(List<List<int>> liste,int a, int b){
  //Etant donné que listeElement[1] (=[1,1]) n'est PAS EGALE à [1,1],on va cook
  for(int k =0;k<liste.length;k++){
    if(a == liste[k][0] && b == liste[k][1]){
      liste.removeAt(k);
    }
  }
}


void main(){

  List<List<int>> mat = creationMatrice(7);
  List<List<int>> matrice = fillWithLight(mat);
  matrice = putNumberOnWalls(matrice);
  matrice = retirerNmAlea(matrice);
  List<List<int>> matSol = onlyWalls(matrice);
 
  List<List<int>> matTest = [[0, 1, 0, 6, 0, 0, 0],[10, 5, 1, 1, 1, 6, 6],[6, 1, 0, 0, 0, 0, 0],[0, 1, 0, 0, 11, 0, 11],[0, 1, 0, 0, 0, 0, 1],[0, 1, 6, 1, 1, 1, 5],[0, 11, 0, 0, 0, 0, 1]];
  for(int k = 0; k<matTest.length;k++){
    print(matTest[k]);
  }
  print("");
  print(listeEmplacementAmpoule);
  listeEmplacementAmpoule.add([1,1]);
  listeEmplacementAmpoule.add([5,6]);

  cliquerCase(matTest, 1, 1);
  for(int k = 0; k<matTest.length;k++){
    print(matTest[k]);
  }
  print("");
  cliquerCase(matTest, 5, 3);
  cliquerCase(matTest, 5, 3);
  print(listeEmplacementAmpoule);
  for(int k = 0; k<matTest.length;k++){
    print(matTest[k]);
  }
  print("");
  cliquerCase(matTest, 5, 3);
  for(int k = 0; k<matTest.length;k++){
    print(matTest[k]);
  }
  print("");

  cliquerCase(matTest, 5, 3);
  cliquerCase(matTest, 5, 3);

  for(int k = 0; k<matTest.length;k++){
    print(matTest[k]);
  }
  print("");

  cliquerCase(matTest, 5, 6);
  
  for(int k = 0; k<matTest.length;k++){
    print(matTest[k]);
  }
  print(listeAction);
  cliquerCase(matTest, 1, 3);
  cliquerCase(matTest, 1, 3);
  for(int k = 0; k<matTest.length;k++){
    print(matTest[k]);
  }
  print("");
  cliquerCase(matTest, 5, 3);

  for(int k = 0; k<matTest.length;k++){
    print(matTest[k]);
  }
  print("");
  annuler(listeAction, matTest);
  for(int k = 0; k<matTest.length;k++){
    print(matTest[k]);
  }
  print("");
  annuler(listeAction,matTest);
  for(int k = 0; k<matTest.length;k++){
    print(matTest[k]);
  }
}

