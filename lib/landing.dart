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
      body: Align(
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
    );
  }
}
