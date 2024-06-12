import 'package:akari_project/database.dart';
import 'package:akari_project/general/background.dart';
import 'package:akari_project/page_accueil/animation_accueil.dart';
import 'package:akari_project/nav_bar/nav_bar.dart';
import 'package:akari_project/general/themes.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:audioplayers/audioplayers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await initDatabase();
  await Hive.openBox('userBox');

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

class _MainAppState extends State<MainApp> with WidgetsBindingObserver {
  late AudioPlayer player = AudioPlayer();

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      player.pause();
    } else {
      player.resume();
    }
  }

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await player.setReleaseMode(ReleaseMode.loop);
      await player.setSource(AssetSource('music/soundtrack.mp3'));
      await player.setVolume(0.2);
      await player.resume();
    });
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    player.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box>(
      valueListenable: Hive.box('userBox').listenable(),
      builder: (context, box, _) {
        var theme = box.get("background");
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              useMaterial3: true,
              fontFamily: MyTheme.getTheme(theme).font // police pour tout
              ),
          home: Scaffold(
            extendBody: true,
            bottomNavigationBar: NavBar(selected: null),
            body: Center(
              child: BackgroundCustom(
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
              ),
            ),
          ),
        );
      },
    );
  }
}
