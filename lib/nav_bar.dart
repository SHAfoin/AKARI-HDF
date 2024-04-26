import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      
      Align(
        alignment: Alignment.topLeft,
        child: FractionallySizedBox(
          widthFactor: 0.55,
          child: Align(
            alignment: Alignment.bottomLeft,
            child: ClipRect(
                child: Align(
                    heightFactor: 0.5,
                    widthFactor: 0.7,
                    alignment: Alignment.topRight,
                    child: ClipOval(
                        child:
                            Container(color: Color(0xff370617), height: 200)))),
          ),
        ),
      ),
      
      Align(
        alignment: Alignment.topRight,
        child: FractionallySizedBox(
          widthFactor: 0.55,
          child: Align(
            alignment: Alignment.bottomRight,
            child: ClipRect(
                child: Align(
                    heightFactor: 0.5,
                    widthFactor: 0.7,
                    alignment: Alignment.topLeft,
                    child: ClipOval(
                        child:
                            Container(color: Color(0xff370617), height: 200)))),
          ),
          
        ),
      ), Align(
        alignment: Alignment.topCenter,
        child: FractionallySizedBox(
          widthFactor: 0.6,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: ClipRect(
                child: Align(
                    heightFactor: 0.5,
                    alignment: Alignment.topCenter,
                    child: ClipOval(
                        child:
                            Container(color: Color(0xFFDC2F02), height: 200)))),
          ),
        ),
      ),
    ]);
  }
}

// 
