import 'package:flutter/material.dart';
import 'package:rishal/screens/home_page.dart';
import 'package:rishal/utils/app_colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void toggleTheme() {
    setState(() {
      AppColors.isDarkMode = !AppColors.isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rishal Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Inter',
        scaffoldBackgroundColor: AppColors.background,
        textTheme: TextTheme(
          headlineLarge: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
          bodyMedium: TextStyle(color: AppColors.textSecondary),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.background,
          iconTheme: IconThemeData(color: AppColors.accent),
        ),
      ),
      home: PortfolioHomePage(onThemeToggle: toggleTheme),
    );
  }
}
