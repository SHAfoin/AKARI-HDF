import 'package:flutter/material.dart';

enum Side {left, right}

class NavBarSideButton extends StatelessWidget {
  final Side side;
  final Widget content;
  const NavBarSideButton({super.key, required this.side, required this.content});

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: (side == Side.right) ? Alignment.topRight : Alignment.topLeft,
        child: Align(
          alignment: (side == Side.right) ? Alignment.bottomRight : Alignment.bottomLeft,
          child: ClipRect(
              child: Align(
                  heightFactor: 0.5,
                  widthFactor: 0.7,
                  alignment: (side == Side.right) ? Alignment.topLeft : Alignment.topRight,
                  child: ClipOval(
                      child: FractionallySizedBox(
                          widthFactor: 0.55,
                          child: Container(
                            color: const Color(0xff370617),
                            height: 200,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top:5),
                                    child: content,
                                  )),
                            ),
                          ))))),
        ),
      );
  }
}

