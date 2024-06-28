import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Define the color palette
  static const Color primaryColor = Color(0xFF007BFF);
  static const Color secondaryColor = Color(0xFF6C757D);
  static const Color accentColor = Color(0xFFFFC107);
  static const Color backgroundColor = Color(0xFFF8F9FA);
  static const Color textColor = Color(0xFF343A40);

  // Define the text styles using Google Fonts
  static final TextTheme textTheme = TextTheme(
    displayLarge: GoogleFonts.roboto(fontSize: 32, fontWeight: FontWeight.bold, color: textColor),
    headlineSmall: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold, color: textColor),
    bodyLarge: GoogleFonts.openSans(fontSize: 16, color: textColor),
    bodyMedium: GoogleFonts.openSans(fontSize: 14, color: textColor),
  );

  // Define the theme data
  static final ThemeData themeData = ThemeData(
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: primaryColor,
      secondary: accentColor,
      background: backgroundColor,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
    ),
    scaffoldBackgroundColor: backgroundColor,
    textTheme: textTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      titleTextStyle: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: accentColor,
        textStyle: GoogleFonts.roboto(fontWeight: FontWeight.bold),
      ),
    ),
  );
}
