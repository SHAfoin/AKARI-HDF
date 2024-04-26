import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavBarCentralButton extends StatelessWidget {
  const NavBarCentralButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
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
      );
  }
}