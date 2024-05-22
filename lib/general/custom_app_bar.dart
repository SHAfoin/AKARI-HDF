import 'package:flutter/material.dart';

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
            child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "Akari",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ))),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: const EdgeInsets.only(right: 5),
                height: kToolbarHeight,
                child: const Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "32",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ))),
            const SizedBox(
                height: kToolbarHeight,
                child: Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 8, left: 5),
                  child: Image(
                      image: AssetImage('assets/images/coin.png')),
                ))
          ],
        ),
      ]),
      backgroundColor: const Color(0xFF352210),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
