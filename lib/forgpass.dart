import 'package:flutter/material.dart';
import 'designs.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController usernameController = TextEditingController();

  void _sendResetInstructions() {
    String username = usernameController.text.trim();

    if (username.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Please enter your username.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK', style: TextStyle(color: accentColor)),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Reset Instructions Sent'),
          content: Text('Instructions to reset your password have been sent to your email.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Center(
              child: Image.network(
                'https://unitedwayofsemo.org/wp-content/uploads/2021/04/United-Way-Logo-White.png',
                width: 100,
                height: 80,
              ),
            ),
          ),
          Positioned(
            top: 100, // Adjust as needed
            left: 0,
            right: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    controller: usernameController,
                    decoration: InputDecoration(labelText: 'Username'),
                    style: TextStyle(color: textColor),
                    cursorColor: accentColor,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _sendResetInstructions,
                    child: Text('Send Reset Instructions', style: TextStyle(color: accentColor)),
                  ),
                ],
              ),
            ),
          ),
          // Diagonal lines
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
          // Additional diagonal lines
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
        ],
      ),
    );
  }
}

// DiagonalLinePainter class
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
