import 'package:akari_project/general/custom_app_bar.dart';
import 'package:akari_project/general/gradient_background.dart';
import 'package:akari_project/main.dart';
import 'package:akari_project/page_niveau/page_niveau.dart';
import 'package:akari_project/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PageVictoire extends StatelessWidget {
  const PageVictoire({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      extendBody: true,
      body: Center(
          child: GradientBackground(
              child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "FÉLICITATIONS!",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 40),
          ),
          const Text(
            "NOUVEAU RECORD!",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
          Expanded(
              child: Container(
            width: double.infinity,
            height: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: ValueListenableBuilder<Box>(
      valueListenable: Hive.box('userBox').listenable(),
      builder: (context, box, _) {
        var theme = box.get("background");
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    "02:03",
                    style: TextStyle(fontSize: 40),
                  ),
                  const Text(
                    "Petit",
                    style: TextStyle(fontSize: 25),
                  ),
                  const SizedBox(
                      height: 250,
                      child: Image(
                          image: AssetImage("assets/images/victory_image.png"))),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "+16",
                          style: TextStyle(fontSize: 30),
                        ),
                        SizedBox(
                            height: 50,
                            child: Image(
                                image: AssetImage("assets/images/coin.png")))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation1, animation2) =>
                                    PageNiveau(),
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero,
                              ),
                              (Route<dynamic> route) => route.isFirst,
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            height: 40,
                            decoration: BoxDecoration(
                              color: MyTheme.getTheme(theme).menu,
                              borderRadius: BorderRadius.circular(20),
                            
                            ),
                            child: Transform.translate(
                              offset: const Offset(0, -3),
                              child: const Text(
                                "Menu",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              ),
                            ),
                            
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 10),
                          height: 40,
                          child: Transform.translate(
                            offset: const Offset(0, -3),
                            child: const Text(
                              "Partager",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: MyTheme.getTheme(theme).partager,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      )
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 40,
                            child: Transform.translate(
                              offset: const Offset(0, -3),
                              child: const Text(
                                "Rejouer",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: MyTheme.getTheme(theme).rejouer,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );},
            ),
          ))
        ],
      ))),
    );
  }
}
