import 'package:flutter/material.dart';

class PageJeuButton extends StatelessWidget {
  final Color color;
  final String text;
  final VoidCallback? onPressed;
  
  final Widget? child;

  const PageJeuButton(
      {super.key,
      required this.color,
      required this.text,
      required this.onPressed,
      this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90,
      height: 90,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          padding: const EdgeInsets.all(0),
          backgroundColor: color,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                text,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            if (child != null) child!,
          ],
        ),
      ),
    );
  }
}
