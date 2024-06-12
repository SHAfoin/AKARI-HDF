import 'package:akari_project/general/themes.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

enum ButtonSide { left, right }

class NavBarSideButton extends StatefulWidget {
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
  State<NavBarSideButton> createState() => _NavBarSideButtonState();
}

class _NavBarSideButtonState extends State<NavBarSideButton> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: (widget.side == ButtonSide.right)
          ? Alignment.topRight
          : Alignment.topLeft,
      child: Align(
        alignment: (widget.side == ButtonSide.right)
            ? Alignment.bottomRight
            : Alignment.bottomLeft,
        child: ClipRect(
          child: Align(
            heightFactor: 0.5,
            widthFactor: 0.7,
            alignment: (widget.side == ButtonSide.right)
                ? Alignment.topLeft
                : Alignment.topRight,
            child: ClipOval(
              child: FractionallySizedBox(
                widthFactor: 0.55,
                child: InkWell(
                  onTap: () async {
                    if (!widget.selected) {
                      AudioPlayer nav = AudioPlayer();
                      await nav.setSourceAsset("music/navigation_sound.mp3");
                      await nav.resume();
                      Navigator.pushAndRemoveUntil(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              widget.pageDestination,
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                        ),
                        (Route<dynamic> route) => route.isFirst,
                      );
                    }
                  },
                  child: ValueListenableBuilder<Box>(
                    valueListenable: Hive.box('userBox').listenable(),
                    builder: (context, box, _) {
                      var theme = box.get("background");
                      return Container(
                        color: MyTheme.getTheme(theme).boutonCote,
                        height: 200,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: widget.content,
                              )),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
