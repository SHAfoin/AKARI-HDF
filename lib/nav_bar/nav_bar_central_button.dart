import 'package:akari_project/nav_bar/nav_bar.dart';
import 'package:akari_project/page_niveau/page_niveau.dart';
import 'package:akari_project/themes.dart';
import 'package:flutter/material.dart';

class NavBarCentralButton extends StatefulWidget {
  final bool selected;
  const NavBarCentralButton({super.key, required this.selected});

  @override
  State<NavBarCentralButton> createState() => _NavBarCentralButtonState();
}

class _NavBarCentralButtonState extends State<NavBarCentralButton> {
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
                        child: InkWell(
                          onTap: () {
                            if (!widget.selected) {
                              
                              Navigator.pushAndRemoveUntil(
                                context,
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation1, animation2) =>
                                          PageNiveau(),
                                  transitionDuration: Duration.zero,
                                  reverseTransitionDuration: Duration.zero,
                                ),(Route<dynamic> route) => route.isFirst,
                              );
                            }
                          },
                          child: Container(
                            color:  MyTheme.getTheme().boutonCentre,
                            height: 200,
                            child: const Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Text(
                                    "JOUER",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 45),
                                  )),
                            ),
                          ),
                        ))))),
      ),
    );
  }
}
