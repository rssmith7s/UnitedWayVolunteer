import 'package:flutter/material.dart';
import 'landing.dart';

const Color primaryColor = Color.fromRGBO(14, 23, 128, 1);
const Color accentColor = Color.fromRGBO(255, 100, 0, 1);
const Color backgroundColor = Color.fromRGBO(39, 39, 39, 1);
const Color alternateColor = Color.fromRGBO(124, 129,184, 1);
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
              MaterialPageRoute(builder: (context) => LandingPage()),
            );
          },
        ),
      ],
      // Add other properties to the AppBar as needed
    );
  }
}

class CustomBackground extends StatelessWidget {
  final Widget child;

  CustomBackground({required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: primaryColor,
        ),
        Positioned(
          top: 0,
          left: 0,
          child: CustomPaint(
            size: Size(40, 40),
            painter: DiagonalLinePainter(isBottomLeftAngle: false),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: CustomPaint(
            size: Size(40, 40),
            painter: DiagonalLinePainter(isBottomLeftAngle: true),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: CustomPaint(
            size: Size(40, 40),
            painter: DiagonalLinePainter(isBottomLeftAngle: true),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: CustomPaint(
            size: Size(40, 40),
            painter: DiagonalLinePainter(isBottomLeftAngle: false),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: CustomPaint(
            size: Size(20, 20),
            painter: DiagonalLinePainter(isBottomLeftAngle: false),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: CustomPaint(
            size: Size(20, 20),
            painter: DiagonalLinePainter(isBottomLeftAngle: true),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: CustomPaint(
            size: Size(20, 20),
            painter: DiagonalLinePainter(isBottomLeftAngle: true),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: CustomPaint(
            size: Size(20, 20),
            painter: DiagonalLinePainter(isBottomLeftAngle: false),
          ),
        ),
        child,
      ],
    );
  }
}

class DiagonalLinePainter extends CustomPainter {
  final bool isBottomLeftAngle;

  DiagonalLinePainter({this.isBottomLeftAngle = true});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = alternateColor
      ..strokeWidth = 3.0;

    if (isBottomLeftAngle) {
      canvas.drawLine(Offset(0, 0), Offset(size.width, size.height), paint);
    } else {
      canvas.drawLine(Offset(size.width, 0), Offset(0, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

