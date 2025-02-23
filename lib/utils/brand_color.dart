import 'package:flutter/material.dart';

class BrandColor {
  BrandColor._();

  //App Basic Colors
  static Color chatInputColor = const Color(0xff1d1d1d);
  static Color primaryColor = Color(0xFF11A33A);
  static const Color secondary = Color(0xFF979797);
  static const Color primaryAccent = Color(0x948DD3AE);

// Gradient Colors
  static const Gradient linearGradient = LinearGradient(
    begin: Alignment(0.0, 0.0),
    end: Alignment(.808, -0.808),
    colors: [
      Color(0xffff9a9e),
      Color(0xfffad0c4),
      Color(0xfffad0c4),
    ],
  );

//Text Colors
  static const Color textPrimary = Color(0xFF333333);
  static const Color textSecondary = Color(0xFF6C757D);
  static const Color textWhite = Colors.white;

// Background Colors
  static const Color light = Color(0xF6F6F6F6);
  static const Color dark = Color(0xFF272727);
  static const Color primaryBackground = Color(0xFFF3F5FF);

//Error and Validation Colors
  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF388E3C);
  static const Color warning = Color(0xFFF57C00);
  static const Color info = Color(0xFF1976D2);

// Neutral Shades
  static const Color black = Color(0xFF232323);
  static const Color darkerGrey = Color(0xFF4F4F4F);
  static const Color darkGrey = Color(0xFF939393);
  static const Color grey = Color(0xFFE0E0E0);
  static const Color softgrey = Color(0xFFF4F4F4);
  static const Color white = Color(0xFFFFFFFF);

}