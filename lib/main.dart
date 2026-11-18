
import 'package:flutter/material.dart';
import 'home_page.dart';

const Color primaryGreen = Color(0xFF16834A);
const Color lightGreen = Color(0xFFE8F5E9);
const Color backgroundGreen = Color(0xFFF5FAF5);

void main() {
  runApp(const BaggageCalculatorApp());
}

class BaggageCalculatorApp extends StatelessWidget {
  const BaggageCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Excess Baggage Calculator',

      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: backgroundGreen,

        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryGreen,
          primary: primaryGreen,
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: primaryGreen,
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 2,
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryGreen,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),

      home: const HomePage(),
    );
  }
}
