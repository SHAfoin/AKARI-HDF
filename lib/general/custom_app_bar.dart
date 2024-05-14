import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          centerTitle: true,
        
          title: const Text('Akari', style: TextStyle(color: Colors.white), ),
          backgroundColor: const Color(0xFF352210),
        );

        
  }
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

}