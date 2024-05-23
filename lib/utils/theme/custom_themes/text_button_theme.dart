import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class TTextButtonTheme {
  TTextButtonTheme._();

  /// Light Theme
  static final lightTextButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: TColors.primaryColor,
      backgroundColor: Colors.transparent,
      textStyle: const TextStyle(fontSize: 16, color: TColors.textWhite, fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(vertical: 18),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );

  // /// Light Theme
  // static final darkTextButtonTheme = TextButtonThemeData(
  //   style: TextButton.styleFrom(
  //     foregroundColor: TColors.primaryColor,
  //     backgroundColor: Colors.transparent,
  //     textStyle: const TextStyle(fontSize: 16, color: TColors.textWhite, fontWeight: FontWeight.w600),
  //     padding: const EdgeInsets.symmetric(vertical: 18),
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  //   ),
  // );

  /// Dark Theme
  static final darkTextButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: TColors.primaryColor,
      backgroundColor: Colors.transparent,
      textStyle: const TextStyle(fontSize: 16, color: TColors.textWhite, fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(vertical: 18),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}
