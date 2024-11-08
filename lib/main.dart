import 'package:avato/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Avato',
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins(fontWeight: FontWeight.normal).fontFamily,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent,elevation: 0),
        useMaterial3: true,
      ),
      home:HomeScreen()
    );
  }
}

