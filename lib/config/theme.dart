import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {

  static const  Color _seedColor = Colors.blueAccent;

  static final _lightColorScheme = ColorScheme.fromSeed(
    seedColor: _seedColor,
  );

  static final _darkColorScheme = ColorScheme.fromSeed(
    seedColor: _seedColor,
    brightness: Brightness.dark,
  );

  static final _lightTextTheme = GoogleFonts.montserratTextTheme(
    ThemeData.light().textTheme,
  );

  static final _darkTextTheme = GoogleFonts.montserratTextTheme(
    ThemeData.dark().textTheme,
  );

  static ThemeData get light {
    return ThemeData.light(useMaterial3: true).copyWith(
      colorScheme: _lightColorScheme,
      textTheme: _lightTextTheme,
    );
  }

  static ThemeData get dark {
    return ThemeData.dark(useMaterial3: true).copyWith(
      colorScheme: _darkColorScheme,
      textTheme: _darkTextTheme,
    );
  }
}
