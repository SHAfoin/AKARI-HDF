import 'package:akari_project/general/gradient_background.dart';
import 'package:akari_project/general/image_background.dart';
import 'package:akari_project/general/themes.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BackgroundCustom extends StatelessWidget {
  final Widget child;
  const BackgroundCustom({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box>(
      valueListenable: Hive.box('userBox').listenable(),
      builder: (context, box, _) {
        return Builder(
          builder: (context) {
            var theme = box.get("background");
            if (MyTheme.getTheme(theme).hasBackgroundImage) {
              return ImageBackground(
                child: child,
              );
            } else {
              return GradientBackground(
                child: child,
              );
            }
            
          },
        );
      },
    );
  }
}
