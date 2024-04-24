import 'package:akari_project/bottom_animation_accueil.dart';
import 'package:akari_project/nav_bar.dart';
import 'package:akari_project/top_animation_accueil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  // Bar de status transparente
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const MainApp());
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
        textTheme: GoogleFonts.concertOneTextTheme(), // police Concert One pour tout
      ),
      home: Scaffold(
        body: Center(
          child: SizedBox.expand(
            child: Container( // dégradé de fond
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFD00000),
                    Color(0xFFFFBA08),
                  ],
                )),
                child: const Column( 
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column( // tous sauf la barre de navigation
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(  // Crédits en haut
                          padding: EdgeInsets.only(top: 50, bottom: 20),
                          child: Text(
                            "LEMAITRE Maxime, MENU Thomas, SALTEL Baptiste",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                        ),
                        SizedBox(height: 175, child: TopAnimation()), // cases mouvantes supérieures
                        Image(  // logo
                            image: AssetImage(
                                'assets/akari_icon_basic.png')),
                        Padding(  // texte d'introduction
                          padding: EdgeInsets.only(bottom: 20),
                          child: Text(
                            "Joues des parties,\nGagnes des pièces,\nCustomises ton jeu !",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                height: 1),
                          ),
                        ),
                        SizedBox(height: 225, child: BottomAnimation()), // cases animées inférieures
                      ],
                    ),
                    // Barre de navigation
                    NavBar()
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
