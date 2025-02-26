import 'package:convo/utils/text_field_theme.dart';
import 'package:flutter/material.dart';
import 'bottom_sheet_theme.dart';
class D_vaultTheme {
  D_vaultTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'poppins',
    brightness: Brightness.light,
    primaryColor: Colors.green,
    canvasColor: Colors.transparent,
    scaffoldBackgroundColor: Colors.white,
    bottomSheetTheme: DBottomSheetTheme.lightBottomSheetTheme,
    inputDecorationTheme: DTextFieldTheme.lightInputDecorationTheme,
  );

  // DARK THEME...
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'poppins',
    brightness: Brightness.dark,
    primaryColor: Colors.green,
    canvasColor: Colors.transparent,
    scaffoldBackgroundColor: Colors.black,
    bottomSheetTheme: DBottomSheetTheme.darkBottomSheetTheme,
    inputDecorationTheme: DTextFieldTheme.darkInputDecorationTheme,

  );
}

