import 'package:costmydegree/pages/quiz_page.dart';
import 'package:costmydegree/pages/result_page.dart';
import 'package:costmydegree/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "CostMyDegree",
      theme: ThemeData(
        primaryColor: Colors.white,
        textTheme: GoogleFonts.outfitTextTheme(),
        primaryTextTheme: GoogleFonts.outfitTextTheme(),
      ),
      home: const WelcomePage(),
      routes: {
        '/quiz': (context) => const QuizPage(),
        '/result': (context) => const ResultPage(),
      },
    );
  }
}
