import 'package:akari_project/general/background.dart';
import 'package:akari_project/general/custom_app_bar.dart';
import 'package:akari_project/nav_bar/nav_bar.dart';
import 'package:akari_project/page_stats/stat.dart';

import 'package:akari_project/page_stats/stat_tile.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PageStats extends StatefulWidget {
  const PageStats({super.key});

  @override
  State<PageStats> createState() => _PageStatsState();
}

class _PageStatsState extends State<PageStats> {
  List<Stat> listeStat = [];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: ((bool didPop) async {
        if (didPop) {
          return;
        }
        AudioPlayer back = AudioPlayer();
        await back.setSourceAsset("music/back_sound.mp3");
        await back.resume();
        Navigator.pop(context);
      }),
      child: Scaffold(
        extendBody: true,
        appBar: const CustomAppBar(),
        bottomNavigationBar: const NavBar(
          selected: NavButton.left,
        ),
        body: Center(
          child: ValueListenableBuilder<Box>(
              valueListenable: Hive.box('userBox').listenable(),
              builder: (context, box, _) {
                return BackgroundCustom(
                  child: ValueListenableBuilder<Box>(
                      valueListenable: Hive.box('statBox').listenable(),
                      builder: (context, box, widget) {
                        var items = box.values.toList();
                        return ListView.builder(
                            padding: const EdgeInsets.only(bottom: 120),
                            shrinkWrap: true,
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              return StatTile(stat: items[index]);
                            });
                      }),
                );
              }),
        ),
      ),
    );
  }
}
