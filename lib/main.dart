import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'opportunity.dart';
import 'landing.dart';
import 'designs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://ynxtlagcgaktgltpzqoa.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlueHRsYWdjZ2FrdGdsdHB6cW9hIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTEzOTkwNTMsImV4cCI6MjAyNjk3NTA1M30.67hjiBJ2er_8wwOyXMLV0nHi1BJ_ZkA7geJn7VE8qMY',
  );
  


  runApp(
    
    ChangeNotifierProvider(
      create: (context) => OpportunityNotifier(),
      child: MyApp(),
    ),
  
  );
}

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