import 'package:akari_project/general/custom_app_bar.dart';
import 'package:akari_project/general/gradient_background.dart';
import 'package:akari_project/main.dart';
import 'package:akari_project/page_niveau/page_niveau.dart';
import 'package:akari_project/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PageVictoire extends StatelessWidget {
  const PageVictoire({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      extendBody: true,
      body: Center(
          child: GradientBackground(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Text(
              "FÉLICITATIONS!",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 40),
            ),
          ),
          Text(
            "NOUVEAU RECORD!",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
          Expanded(
              child: Container(
            width: double.infinity,
            height: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                Text(
                  "02:03",
                  style: TextStyle(fontSize: 40),
                ),
                Text(
                  "Petit",
                  style: TextStyle(fontSize: 25),
                ),
                Container(
                    height: 250,
                    child: Image(
                        image: AssetImage("assets/images/victory_image.png"))),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "+16",
                        style: TextStyle(fontSize: 30),
                      ),
                      Container(
                          height: 50,
                          child: Image(
                              image: AssetImage("assets/images/coin.png")))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                        Navigator.pushAndRemoveUntil(
                                context,
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation1, animation2) =>
                                          MainApp(),
                                  transitionDuration: Duration.zero,
                                  reverseTransitionDuration: Duration.zero,
                                ),(Route<dynamic> route) => route.isFirst,
                              );
                      },
                        child: Container(
                          margin: EdgeInsets.only(right: 10),
                          height: 40,
                          child: Transform.translate(
                            offset: Offset(0, -3),
                            child: Text(
                              "Menu",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: MyTheme.getTheme().menu,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        height: 40,
                        child: Transform.translate(
                          offset: Offset(0, -3),
                          child: Text(
                            "Partager",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: MyTheme.getTheme().partager,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    )
                  ]),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 40,
                          child: Transform.translate(
                            offset: Offset(0, -3),
                            child: Text(
                              "Rejouer",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: MyTheme.getTheme().rejouer,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ))
        ],
      ))),
    );
  }
}
