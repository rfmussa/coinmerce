import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get light {
    final base = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.deepPurple,
      ),
      useMaterial3: true,
    );
    return base.copyWith(
      textTheme: GoogleFonts.montserratTextTheme(base.textTheme),
    );
  }

  static ThemeData get dark {
    final base = ThemeData.dark(useMaterial3: true);
    return base.copyWith(
      textTheme: GoogleFonts.montserratTextTheme(base.textTheme),
    );
  }
}
