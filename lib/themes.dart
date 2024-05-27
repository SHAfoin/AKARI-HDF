import 'package:flutter/material.dart';

class MyTheme {
  final bool hasBackgroundImage;
  final AssetImage? backgroundImage;
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
  final Color shopItem;
  final Color indice;
  final Color solution;
  final Color quitter;
  final Color menu;
  final Color partager;
  final Color rejouer;

  MyTheme(
      this.hasBackgroundImage,
      this.backgroundImage,
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
      this.shopItem,
      this.indice,
      this.solution,
      this.quitter,
      this.menu,
      this.partager,
      this.rejouer);

  static List<MyTheme> themes = <MyTheme>[
    MyTheme(
      // Theme Rouge
      false, // Has Background Image
      null, // Background Image
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
      const Color(0xFF6A040F), // Shop Item
      const Color(0xFF6A040F), // Indice
      const Color(0xFFD00000), // Solution
      const Color(0xFFE85D04), // Quitter
      const Color(0xFF352210), // Menu
      const Color(0xFFE85D04), // Partager
      const Color(0xFFD00000), // Rejouer
    ),
    MyTheme(
      // Theme Bleu
      false, // Has Background Image
      null, // Background Image
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
      const Color(0xFF10046B), // Shop Item
      const Color(0xFF10046B), // Indice
      const Color(0xFF0049D1), // Solution
      const Color(0xFF0586E8), // Quitter
      const Color(0xFF1A1036), // Menu
      const Color(0xFF0586E8), // Partager
      const Color(0xFF0049D1), // Rejouer
    ),
    MyTheme(
      // Theme Vert
      false, // Has Background Image
      null, // Background Image
      const AssetImage('assets/images/akari_icon_basic.png'), // Logo
      const AssetImage('assets/images/coin.png'), // Monnaie
      const Color(0xFF004802), // Bouton cote
      const Color(0xFF428417), // Bonton centre
      const Color(0xFF40E317), // Petit
      const Color(0xFF1D8C0C), // Moyen
      const Color(0xFF155D27), // Grand
      const Color(0xFF003601), // Header
      const Color(0xFF024F02), // Degradé haut
      const Color(0xFF82C614), // Dégradé bas
      const Color(0xFF025000), // Stats
      const Color(0xFF1E2F23), // Shop
      const Color(0xFF076605), // Shop Item
      const Color(0xFF004823), // Indice
      const Color(0xFF006900), // Solution
      const Color(0xFF17AD00), // Quitter
      const Color(0xFF004823), // Menu
      const Color(0xFF008000), // Partager
      const Color(0xFF29BF12), // Rejouer
    ),
    MyTheme(
      // Theme Minecraft
      true, // Has Background Image
      const AssetImage(
          'assets/images/shop_items/background_minecraft.png'), // Background Image
      const AssetImage('assets/images/akari_icon_basic.png'), // Logo
      const AssetImage('assets/images/coin_minecraft.png'), // Monnaie
      const Color(0xFF233610), // Bouton cote
      const Color(0xFF4AC000), // Bonton centre
      const Color(0xFF45D900), // Petit
      const Color(0xFF2F9C00), // Moyen
      const Color(0xFF336B04), // Grand
      const Color(0xFF233610), // Header
      const Color(0xFFFFFFFF), // Degradé haut
      const Color(0xFFFFFFFF), // Dégradé bas
      const Color(0xFF4E831A), // Stats
      const Color(0xFF233610), // Shop
      const Color(0xFF336B04), // Shop Item
      const Color(0xFF336B04), // Indice
      const Color(0xFF2F9C00), // Solution
      const Color(0xFF45D900), // Quitter
      const Color(0xFF233610), // Menu
      const Color(0xFF45D900), // Partager
      const Color(0xFF2F9C00), // Rejouer
    ),
    MyTheme(
      // Theme Steampunk
      true, // Has Background Image
      const AssetImage(
          'assets/images/shop_items/background_steampunk.jpg'), // Background Image
      const AssetImage('assets/images/akari_icon_basic.png'), // Logo
      const AssetImage('assets/images/coin.png'), // Monnaie
      const Color(0xFF5A380B), // Bouton cote
      const Color(0xFFB95C0A), // Bonton centre
      const Color(0xFFC46219), // Petit
      const Color(0xFFA04005), // Moyen
      const Color(0xFF862906), // Grand
      const Color(0xFF522619), // Header
      const Color(0xFFFFFFFF), // Degradé haut
      const Color(0xFFFFFFFF), // Dégradé bas
      const Color(0xFFF18805), // Stats
      const Color(0xFF995E20), // Shop
      const Color(0xFF9F4B31), // Shop Item
      const Color(0xFF853000), // Indice
      const Color(0xFFD36341), // Solution
      const Color(0xFFF59864), // Quitter
      const Color(0xFF853000), // Menu
      const Color(0xFFD36341), // Partager
      const Color(0xFFF59864), // Rejouer
    ),
    MyTheme(
      // Theme Japon
      true, // Has Background Image
      const AssetImage(
          'assets/images/shop_items/background_sakura.jpg'), // Background Image
      const AssetImage('assets/images/akari_icon_basic.png'), // Logo
      const AssetImage('assets/images/coin.png'), // Monnaie
      const Color(0xFFC05299), // Bouton cote
      const Color(0xFF973AA8), // Bonton centre
      const Color(0xFF854798), // Petit
      const Color(0xFFBD2D87), // Moyen
      const Color(0xFF680E4B), // Grand
      const Color(0xFF3D2645), // Header
      const Color(0xFFFFFFFF), // Degradé haut
      const Color(0xFFFFFFFF), // Dégradé bas
      const Color(0xFFB388EB), // Stats
      const Color(0xFF932F6D), // Shop
      const Color(0xFFD972FF), // Shop Item
      const Color(0xFF5C026C), // Indice
      const Color(0xFF883677), // Solution
      const Color(0xFFEA9AB2), // Quitter
      const Color(0xFF5C026C), // Menu
      const Color(0xFF883677), // Partager
      const Color(0xFFEA9AB2), // Rejouer
    ),
  ];

  static MyTheme getTheme(int choice) {
    return choice < themes.length ? themes[choice] : themes[0];
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

class Bulb {
  final Color eclairage;
  final AssetImage ampoule;

  Bulb(this.eclairage, this.ampoule);
  static List<Bulb> bulbs = <Bulb>[
    Bulb(const Color(0xFFFFFF00),
        const AssetImage('assets/images/shop_items/bulb_yellow.png')),
    Bulb(const Color(0xFF0000FF),
        const AssetImage('assets/images/shop_items/bulb_blue.png')),
    Bulb(const Color(0xFF00FF00),
        const AssetImage('assets/images/shop_items/bulb_green.png')),
    Bulb(const Color(0xFFFFA000),
        const AssetImage('assets/images/shop_items/bulb_minecraft.png')),
    Bulb(const Color(0xFFEA9AB2),
        const AssetImage('assets/images/shop_items/bulb_japanese.png')),
    Bulb(const Color(0xFFB95C0A),
        const AssetImage('assets/images/shop_items/bulb_steampunk.png')),
  ];

  static Bulb getAmpoule(int choice) {
    return choice < bulbs.length ? bulbs[choice] : bulbs[0];
  }
}
