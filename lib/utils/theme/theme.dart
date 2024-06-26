import 'package:flutter/material.dart';

import '../constants/colors.dart';
import 'custom_themes/appbar_theme.dart';
import 'custom_themes/bottom_sheet_theme.dart';
import 'custom_themes/checkbox_theme.dart';
import 'custom_themes/chip_theme.dart';
import 'custom_themes/elevated_button_theme.dart';
import 'custom_themes/outlined_button_theme.dart';
import 'custom_themes/text_button_theme.dart';
import 'custom_themes/text_field_theme.dart';
import 'custom_themes/text_selection_theme.dart';
import 'custom_themes/text_theme.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: TColors.primaryColor,
    textTheme: TTextTheme.lightTextTheme,
    chipTheme: TChipTheme.lightChipTheme,
    scaffoldBackgroundColor: TColors.light,
    appBarTheme: TAppBarTheme.lightAppBarTheme,
    checkboxTheme: TCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: TBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButtonTheme,
    textButtonTheme: TTextButtonTheme.lightTextButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme,
    textSelectionTheme: TTextSelectionTheme.lightTextSelectionTheme,
  );

  // static ThemeData darkTheme = ThemeData(
  //   useMaterial3: true,
  //   fontFamily: 'Poppins',
  //   brightness: Brightness.light,
  //   primaryColor: TColors.primaryColor,
  //   textTheme: TTextTheme.lightTextTheme,
  //   chipTheme: TChipTheme.lightChipTheme,
  //   scaffoldBackgroundColor: TColors.light,
  //   appBarTheme: TAppBarTheme.lightAppBarTheme,
  //   checkboxTheme: TCheckboxTheme.lightCheckboxTheme,
  //   bottomSheetTheme: TBottomSheetTheme.lightBottomSheetTheme,
  //   elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
  //   outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButtonTheme,
  //   textButtonTheme: TTextButtonTheme.lightTextButtonTheme,
  //   inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme,
  //   textSelectionTheme: TTextSelectionTheme.lightTextSelectionTheme,
  // );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: TColors.primaryColor,
    textTheme: TTextTheme.darkTextTheme,
    chipTheme: TChipTheme.lightChipTheme,
    scaffoldBackgroundColor: TColors.dark,
    // scaffoldBackgroundColor: TColors.white,
    appBarTheme: TAppBarTheme.darkAppBarTheme,
    checkboxTheme: TCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: TBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.darkOutlinedButtonTheme,
    textButtonTheme: TTextButtonTheme.darkTextButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.darkInputDecorationTheme,
    textSelectionTheme: TTextSelectionTheme.darkTextSelectionTheme,
  );
}
