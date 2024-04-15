import 'package:flutter/material.dart';
import 'package:flutter_application_1/designs.dart';
import 'login.dart';
import 'volunteer.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  void _loginpage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  void _guest() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => VolunteerPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'United Way of SEMO',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20), // Reduced font size to 20
        ),
        centerTitle: true,
      ),
      body: CustomBackground(
        child: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Volunteer with UWSEMO!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 100,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                    fit: BoxFit.fitWidth,
                    image: NetworkImage('https://unitedwayofsemo.org/wp-content/uploads/2021/04/United-Way-Logo-White.png'),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _loginpage,
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(200, 50)),
                ),
                child: const Text('Login',
                  style: TextStyle(fontSize: 18, color: accentColor),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _guest,
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(200, 50)),
                ),
                child: const Text("Sign Up",
                  style: TextStyle(fontSize: 18, color: accentColor),
                ),
              ),
            ],
          ),
        ),
      ),
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
        // Additional lines with size 20x20
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
      ..color = Colors.white
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
