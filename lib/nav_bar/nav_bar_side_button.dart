import 'package:akari_project/themes.dart';
import 'package:flutter/material.dart';

enum ButtonSide { left, right }

class NavBarSideButton extends StatelessWidget {
  final ButtonSide side;
  final Widget pageDestination;
  final bool selected;
  final Widget? content;

  const NavBarSideButton(
      {super.key,
      required this.side,
      required this.content,
      required this.selected,
      required this.pageDestination});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:
          (side == ButtonSide.right) ? Alignment.topRight : Alignment.topLeft,
      child: Align(
        alignment: (side == ButtonSide.right)
            ? Alignment.bottomRight
            : Alignment.bottomLeft,
        child: ClipRect(
            child: Align(
                heightFactor: 0.5,
                widthFactor: 0.7,
                alignment: (side == ButtonSide.right)
                    ? Alignment.topLeft
                    : Alignment.topRight,
                child: ClipOval(
                    child: FractionallySizedBox(
                        widthFactor: 0.55,
                        child: InkWell(
                          onTap: () {
                            if (!selected) {
                              
                              Navigator.pushAndRemoveUntil(
                                context,
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation1, animation2) =>
                                          pageDestination,
                                  transitionDuration: Duration.zero,
                                  reverseTransitionDuration: Duration.zero,
                                ),(Route<dynamic> route) => route.isFirst,
                              );
                            }
                          },
                          child: Container(
                            color: MyTheme.getTheme().boutonCote,
                            height: 200,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: content,
                                  )),
                            ),
                          ),
                        ))))),
      ),
    );
  }
}
