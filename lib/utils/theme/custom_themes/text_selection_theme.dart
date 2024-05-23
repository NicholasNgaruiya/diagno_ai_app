import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class TTextSelectionTheme {
  TTextSelectionTheme._();

  static TextSelectionThemeData lightTextSelectionTheme = TextSelectionThemeData(
    cursorColor: TColors.primaryColor, // Set cursor color for light mode
    selectionColor: TColors.primaryColor.withOpacity(0.3),
    selectionHandleColor: TColors.primaryColor,
  );
  // static TextSelectionThemeData darkTextSelectionTheme = TextSelectionThemeData(
  //   cursorColor: TColors.primaryColor, // Set cursor color for light mode
  //   selectionColor: TColors.primaryColor.withOpacity(0.3),
  //   selectionHandleColor: TColors.primaryColor,
  // );

  static TextSelectionThemeData darkTextSelectionTheme = TextSelectionThemeData(
    cursorColor: TColors.primaryColor, // Set cursor color for light mode
    selectionColor: TColors.primaryColor.withOpacity(0.3),
    selectionHandleColor: TColors.primaryColor,
  );
}
