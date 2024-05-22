import 'package:flutter/material.dart';

enum Size { petit, moyen, grand }

class Level {
  final Size size;
  final String icon;
  final Color color;

  Level({required this.size, required this.icon, required this.color});
}