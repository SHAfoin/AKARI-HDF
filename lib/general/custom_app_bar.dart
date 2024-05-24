import 'package:akari_project/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(
        color: Colors.white, //change your color here
      ),
      centerTitle: true,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const SizedBox(
            height: kToolbarHeight,
            child: const Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "Akari",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ))),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ValueListenableBuilder<Box>(
                valueListenable: Hive.box('userBox').listenable(),
                builder: (context, box, widget) {
                  
                  return Container(
                      padding: const EdgeInsets.only(right: 5),
                      height: kToolbarHeight,
                      child: Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            box.get("coins").toString(),
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          )));
                }),
            const SizedBox(
                height: kToolbarHeight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 8, left: 5),
                  child: Image(image: MyTheme.getTheme().monnaie),
                ))
          ],
        ),
      ]),
      backgroundColor: MyTheme.getTheme().header,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
