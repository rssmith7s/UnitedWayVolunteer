import 'package:flutter/material.dart';
import 'admin.dart';
import 'partner.dart';
import 'forgpass.dart';
import 'designs.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void _login() {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();

    if (username == 'admin' && password == 'adminpassword') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AdminPage()),
      );
    } else if (username == 'partner' && password == 'partnerpassword') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PartnerPage()),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Login Failed'),
          content: const Text('Invalid username or password.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK', style: TextStyle(color:primaryColor)),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
              style: const TextStyle(color: textColor),
              cursorColor: accentColor,
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
              style: const TextStyle(color: textColor),
              cursorColor: accentColor,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Login',
              style: TextStyle(color: accentColor),
              ),
              
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ForgotPasswordPage()),
                );
              },
              child: const Text('Forgot Password?',
              style: TextStyle(color: accentColor)),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
