import 'package:akari_project/nav_bar/nav_bar.dart';
import 'package:akari_project/page_niveau/page_niveau.dart';
import 'package:flutter/material.dart';

class NavBarCentralButton extends StatelessWidget {
  final bool selected;
  const NavBarCentralButton({super.key, required this.selected});

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
                            if (!selected) {
                              Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation1, animation2) =>
                                        const PageNiveau(),
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero,
                              ),
                            );
                            }
                            
                          },
                          child: Container(
                            color: const Color(0xFFDC2F02),
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
