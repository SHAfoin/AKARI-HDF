import 'package:akari_project/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;

  const GradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box>(
      valueListenable: Hive.box('userBox').listenable(),
      builder: (context, box, _) {
        var theme = box.get("background");
      return Container(
        width: double.infinity,
        height: double.infinity,
        decoration:  BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0, 0.6],
          colors: [
            MyTheme.getTheme(theme).degradeHaut,
            MyTheme.getTheme(theme).degradeBas,
          ],
          
        ),
        
        ),
        child: child,
      );},
    );
  }
}
