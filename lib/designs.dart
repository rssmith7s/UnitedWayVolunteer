import 'package:flutter/material.dart';
import 'landing.dart';

const Color primaryColor = Color.fromRGBO(14, 23, 128, 1);
const Color accentColor = Color.fromRGBO(255, 100, 0, 1);
const Color backgroundColor = Color.fromRGBO(39, 39, 39, 1);
const Color textColor = Colors.white;

const InputDecorationTheme customInTheme = InputDecorationTheme(
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: accentColor),
  ),
  labelStyle: TextStyle(color: Colors.white),
  // Add other InputDecoration properties as needed
);

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('United Way of SEMO'),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(Icons.lock),
          onPressed: () {
            Navigator.pushReplacement(
              context, 
              MaterialPageRoute(builder: (context)=>LandingPage())
            );
          },
        ),
      ],
      // Add other properties to the AppBar as needed
    );
  }
}
