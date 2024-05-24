import 'package:flutter/material.dart';

class MyTheme {
  final AssetImage monnaie;
  final AssetImage logo;
  final Color header;
  final Color degradeHaut;
  final Color degradeBas;
  final Color boutonCentre;
  final Color boutonCote;
  final Color petit;
  final Color moyen;
  final Color grand;
  final Color stats;
  final Color shop;
  final Color indice;
  final Color solution;
  final Color quitter;
  final Color menu;
  final Color partager;
  final Color rejouer;

  static int choix = 0;

  MyTheme(
      this.logo,
      this.monnaie,
      this.boutonCote,
      this.boutonCentre,
      this.petit,
      this.moyen,
      this.grand,
      this.header,
      this.degradeHaut,
      this.degradeBas,
      this.stats,
      this.shop,
      this.indice,
      this.solution,
      this.quitter,
      this.menu,
      this.partager,
      this.rejouer);

  static void selectTheme(int index) {
    choix = index < themes.length ? index : 0;
  }

  static List<MyTheme> themes = <MyTheme>[
    MyTheme(
      const AssetImage('assets/images/akari_icon_basic.png'), // Logo
      const AssetImage('assets/images/coin.png'), // Monnaie
      const Color(0xFF370617), // Bouton cote
      const Color(0xFFDC2F02), // Bonton centre
      const Color(0xFFFFBA08), // Petit
      const Color(0xFFE85D04), // Moyen
      const Color(0xFFD00000), // Grand
      const Color(0xFF352210), // Header
      const Color(0xFFD00000), // Degradé haut
      const Color(0xFFFFBA08), // Dégradé bas
      const Color(0xFF9D0208), // Stats
      const Color(0xFF370617), // Shop
      const Color(0xFF6A040F), // Indice
      const Color(0xFFD00000), // Solution
      const Color(0xFFE85D04), // Quitter
      const Color(0xFF352210), // Menu
      const Color(0xFFE85D04), // Partager
      const Color(0xFFD00000), // Rejouer
    ),
    MyTheme(
      const AssetImage('assets/images/akari_icon_basic.png'), // Logo
      const AssetImage('assets/images/coin.png'), // Monnaie
      const Color(0xFF1A1036), // Bouton cote
      const Color(0xFF0268DB), // Bonton centre
      const Color(0xFF2AD0F2), // Petit
      const Color(0xFF0586E8), // Moyen
      const Color(0xFF0268DB), // Grand
      const Color(0xFF1A1036), // Header
      const Color(0xFF0049D1), // Degradé haut
      const Color(0xFF6FE7FF), // Dégradé bas
      const Color(0xFF02299E), // Stats
      const Color(0xFF1A1036), // Shop
      const Color(0xFF10046B), // Indice
      const Color(0xFF0049D1), // Solution
      const Color(0xFF0586E8), // Quitter
      const Color(0xFF1A1036), // Menu
      const Color(0xFF0586E8), // Partager
      const Color(0xFF0049D1), // Rejouer
    ),
  ];

  static MyTheme getTheme() {
    return themes[choix];
  }
}

class TextPerso extends StatelessWidget {
  final String texte;
  final double taillePolice;
  final double offset;
  const TextPerso(this.texte, this.taillePolice, {super.key}) : offset = 0;
  const TextPerso.withOffset(this.texte, this.taillePolice, this.offset,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, offset),
      child: Text(
        texte,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontSize: taillePolice),
      ),
    );
  }
}
