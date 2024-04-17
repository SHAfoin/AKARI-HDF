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
        textTheme: GoogleFonts.concertOneTextTheme(),
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
                  
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  
                  children: [
                    
                    
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Text(
                        "LEMAITRE Maxime, MENU Thomas, SALTEL Baptiste",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 12 ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 100),
                      child: Column(
                        children: [Image(image: AssetImage('assets/akari_icon_basic.png')),Text(
                        "Joue des parties,\nGagne des pièces,\nCustomise ton jeu !",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )],
                      ),
                    ),

                    Text("this is supposed to be the navigation bar"),
                    
                    
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
