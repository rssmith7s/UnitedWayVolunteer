import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'opportunity.dart';
import 'landing.dart';
import 'designs.dart';

void main() => runApp(
      ChangeNotifierProvider(
        create: (context) => OpportunityNotifier(),
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'United Way of SEMO',
      theme: ThemeData(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: primaryColor,
        unselectedWidgetColor: accentColor,
        appBarTheme: AppBarTheme(color: accentColor),
        inputDecorationTheme: customInTheme,
      ),
      home: LandingPage(),
    );
  }
}