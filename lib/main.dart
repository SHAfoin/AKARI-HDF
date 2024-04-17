import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: Scaffold(
        body: Center(
          child: SizedBox.expand(
            child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFD00000),
                    Color(0xFFFFBA08),
                  ],
                )),
                child: Column(
                  
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    
                    Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(color: Colors.black),
                  ),
                    Text(
                      "LEMAITRE Maxime, MENU Thomas, SALTEL Baptiste",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.concertOne(color: Colors.white, fontSize: 12 ),
                    ),
                    Image(image: AssetImage('assets/akari_icon_basic.png')),
                    Text(
                      "Joue des parties,\nGagne des pièces,\nCustomise ton jeu !",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.concertOne(color: Colors.white, fontSize: 20 ),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
