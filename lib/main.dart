import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'opportunity.dart';
import 'landing.dart';
import 'designs.dart';

void main() => runApp(
      ChangeNotifierProvider(
        create: (context) => OpportunityNotifier(),
        child: const MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'United Way of SEMO',
      theme: ThemeData(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: primaryColor,
        unselectedWidgetColor: accentColor,
        appBarTheme: const AppBarTheme(color: accentColor),
        inputDecorationTheme: customInTheme,
      ),
      home: const LandingPage(),
    );
  }
}