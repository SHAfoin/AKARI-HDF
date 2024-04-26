import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Align(
        alignment: Alignment.topLeft,
        child: Align(
          alignment: Alignment.bottomLeft,
          child: ClipRect(
              child: Align(
                  heightFactor: 0.5,
                  widthFactor: 0.7,
                  alignment: Alignment.topRight,
                  child: ClipOval(
                      child: FractionallySizedBox(
                          widthFactor: 0.55,
                          child: Container(
                            color: const Color(0xff370617),
                            height: 200,
                            child: const Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Padding(
                                    padding: EdgeInsets.only(top:5),
                                    child: Column(
                                      children: [
                                        Icon(Icons.format_list_numbered, color: Colors.white, size: 50,),
                                        Text(
                                          "Stats",
                                          style: TextStyle(color: Colors.white, fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                          ))))),
        ),
      ),
      Align(
        alignment: Alignment.topRight,
        child: Align(
          alignment: Alignment.bottomRight,
          child: ClipRect(
              child: Align(
                  heightFactor: 0.5,
                  widthFactor: 0.7,
                  alignment: Alignment.topLeft,
                  child: ClipOval(
                      child: FractionallySizedBox(
                          widthFactor: 0.55,
                          child: Container(
                            color: const Color(0xff370617),
                            height: 200,
                            child: const Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Padding(
                                    padding: EdgeInsets.only(top:5),
                                    child: Column(
                                      children: [
                                        Icon(Icons.storefront_outlined, color: Colors.white, size: 50,),
                                        Text(
                                          "Shop",
                                          style: TextStyle(color: Colors.white, fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                          ))))),
        ),
      ),
      
      Align(
        alignment: Alignment.topCenter,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: ClipRect(
              child: Align(
                  heightFactor: 0.5,
                  alignment: Alignment.topCenter,
                  child: ClipOval(
                      child: FractionallySizedBox(
                          widthFactor: 0.6,
                          child: Container(
                            color: const Color(0xFFDC2F02),
                            height: 200,
                            child: const Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Text(
                                    "JOUER",
                                    style: TextStyle(color: Colors.white, fontSize: 45),
                                  )),
                            ),
                          ))))),
        ),
      ),
    ]);
  }
}

// 
