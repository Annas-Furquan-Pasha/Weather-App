import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import './screens/home_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

final theme = ThemeData().copyWith(
    scaffoldBackgroundColor: const Color.fromRGBO(255, 254, 229, 1),
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.amber),
    appBarTheme: const AppBarTheme(color: Colors.greenAccent),
    textTheme: GoogleFonts.ubuntuCondensedTextTheme().copyWith(
      titleSmall: GoogleFonts.ubuntuCondensed(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: GoogleFonts.ubuntuCondensed(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: GoogleFonts.ubuntuCondensed(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: GoogleFonts.ubuntuCondensed (
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 24
      ),
      bodyMedium: GoogleFonts.ubuntuCondensed(
        color: Colors.black,
        fontSize : 20,
        fontWeight: FontWeight.bold,
      )
    ),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: theme,
      home: const HomeScreen(),
    );
  }
}
