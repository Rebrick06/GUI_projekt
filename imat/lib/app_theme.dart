import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Padding information below // 
  static const double paddingTiny = 4.0;
  static const double paddingSmall = 8.0;
  static const double paddingMediumSmall = 12.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double paddingHuge = 32.0;
 
  // Font styles below // 
  static TextStyle titleFont = GoogleFonts.getFont('Inter');
  static TextStyle textFont = GoogleFonts.getFont('Montserrat'); 

  // ColorScheme below // 
  static ColorScheme colorScheme = ColorScheme.fromSeed(seedColor: Colors.blue);

  static Color darkColor = Color.fromRGBO(14,106,28, 1);
  static Color mainColor = Color.fromRGBO(23, 177, 46, 1);
  static Color brightColor = Color.fromRGBO(176, 230, 185, 1);
  static Color whiteColor = Color.fromRGBO(255, 255, 255, 1);

}
