import 'package:akari_project/database.dart';
import 'package:akari_project/general/background.dart';
import 'package:akari_project/general/gradient_background.dart';
import 'package:akari_project/general/image_background.dart';
import 'package:akari_project/mecaniques/partie.dart';
import 'package:akari_project/page_accueil/animation_accueil.dart';
import 'package:akari_project/nav_bar/nav_bar.dart';

import 'package:akari_project/mecaniques/models.dart';
import 'package:akari_project/page_shop/shop_item.dart';
import 'package:akari_project/page_stats/stat.dart';
import 'package:akari_project/mecaniques/solution.dart';
import 'package:akari_project/general/themes.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await initDatabase();
  await Hive.openBox('userBox');

  final List<List<int>> matrice1 = [
    [0, 12, 0, 10, 0, 0, 0],
    [0, 0, 0, 11, 0, 0, 10],
    [0, 0, 0, 0, 0, 0, 0],
    [11, 10, 0, 0, 0, 6, 6],
    [0, 0, 0, 0, 0, 0, 0],
    [11, 0, 0, 10, 0, 0, 0],
    [0, 0, 0, 6, 0, 12, 0]
  ];
  final List<List<int>> matrice2 = [
    [0, 0, 0, 0, 6, 0, 0],
    [0, 0, 13, 0, 0, 0, 0],
    [12, 0, 0, 14, 0, 6, 0],
    [0, 0, 6, 0, 6, 0, 0],
    [0, 6, 0, 6, 0, 0, 11],
    [0, 0, 0, 0, 13, 0, 0],
    [0, 0, 10, 0, 0, 0, 0]
  ];
  var solv = Solveur();
  Grille puzzle = Grille.newGrille(matrice1);
  List<Grille> solutions = solv.backtrackSolveur(puzzle);
  for (var grille in solutions) {
    grille.afficherMat();
  }

  
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const MainApp()));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        textTheme:
            GoogleFonts.concertOneTextTheme(), // police Concert One pour tout
      ),
      home: Scaffold(
        extendBody: true,
        bottomNavigationBar: NavBar(selected: null),
        body: Center(
          child: ValueListenableBuilder<Box>(
            valueListenable: Hive.box('userBox').listenable(),
            builder: (context, box, _) {
              int theme = box.get("background");
              return BackgroundCustom(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      // tous sauf la barre de navigation
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                          // Crédits en haut
                          padding: EdgeInsets.only(top: 50, bottom: 20),
                          child: Text(
                            "LEMAITRE Maxime, MENU Thomas, SALTEL Baptiste",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                        ),
                        const SizedBox(
                            height: 175,
                            child: AnimationAccueil(
                              side: Side.top,
                            )), // cases mouvantes supérieures
                        Image(
                            // logo
                            image: MyTheme.getTheme(theme).logo),
                        const Padding(
                          // texte d'introduction
                          padding: EdgeInsets.only(bottom: 20),
                          child: Text(
                            "Joues des parties,\nGagnes des pièces,\nCustomises ton jeu !",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white, fontSize: 30, height: 1),
                          ),
                        ),
                        const SizedBox(
                            height: 225,
                            child: AnimationAccueil(
                              side: Side.bottom,
                            )), // cases animées inférieures
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
