import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(
        color: Colors.white, //change your color here
      ),
      centerTitle: true,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
            height: kToolbarHeight,
            child: Align(
                alignment: Alignment.topCenter,
                child: const Text(
                  "Akari",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ))),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: const EdgeInsets.only(right: 5),
                height: kToolbarHeight,
                child: Align(
                    alignment: Alignment.topCenter,
                    child: const Text(
                      "32",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ))),
            Container(
                height: kToolbarHeight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 8, left: 5),
                  child: Image(
                      image: const AssetImage('assets/images/coin.png')),
                ))
          ],
        ),
      ]),
      backgroundColor: const Color(0xFF352210),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
