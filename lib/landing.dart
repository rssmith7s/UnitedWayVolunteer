import 'package:flutter/material.dart';
import 'designs.dart';
import 'login.dart';
import 'volunteer.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  void _loginpage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  void _guest() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const VolunteerPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('United Way of SEMO'),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(
              left: 4), // Adjust the left padding as needed
          child: Container(
            width: 100,
            height: 80,
            decoration: const BoxDecoration(
                shape: BoxShape.rectangle,
                image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: NetworkImage(
                      'https://unitedwayofsemo.org/wp-content/uploads/2021/04/United-Way-Logo-White.png'),
                )),
          ),
        ),
      ),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _loginpage,
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(300, 100)),
              ),
              child: const Text(
                'Login',
                style: TextStyle(fontSize: 18, color: accentColor),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _guest,
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(300, 100)),
              ),
              child: const Text(
                "Continue as Volunteer",
                style: TextStyle(fontSize: 18, color: accentColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
