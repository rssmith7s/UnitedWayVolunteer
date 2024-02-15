
import 'package:flutter/material.dart';
import 'package:united_way/landing.dart';

const Color primaryColor = Color.fromRGBO(39, 39, 39, 1);
const Color accentColor = Color.fromRGBO(255, 100, 0, 1);
const Color backgroundColor = Color.fromRGBO(39, 39, 39, 1);
const Color textColor = Colors.white;

const InputDecorationTheme customInTheme =InputDecorationTheme(
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: accentColor),
  ),
  labelStyle: TextStyle(color: Colors.white),
  // Add other InputDecoration properties as needed
);

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String imageUrl = 'https://unitedwayofsemo.org/wp-content/uploads/2021/04/United-Way-Logo-White.png';

  CustomAppBar();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('United Way of SEMO'),
      centerTitle: true,
      leading: Padding(
        padding: EdgeInsets.only(left: 4), // Adjust the left padding as needed
        child: Container(
          width: 100,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            image: DecorationImage(
              fit: BoxFit.fitWidth,
              image: NetworkImage(imageUrl),
            ) 
          ),
        ),
      ),
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
