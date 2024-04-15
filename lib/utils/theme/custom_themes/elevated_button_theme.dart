import 'package:flutter/material.dart';
import 'package:restaurant_frontend/utils/constants/colors.dart';

class TElevatedButtonTheme {
  TElevatedButtonTheme._();

  ///--Light Theme
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: TColors.black,
      backgroundColor: TColors.buttonPrimary,
      disabledForegroundColor: TColors.buttonDisabled,
      disabledBackgroundColor: TColors.buttonDisabled,
      side: const BorderSide(color: TColors.success),
      padding: const EdgeInsets.symmetric(vertical: 18),
      textStyle: const TextStyle(fontSize: 16, color: TColors.textWhite, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );

  ///---Dark Theme
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: TColors.white,
      backgroundColor: TColors.buttonPrimary,
      disabledForegroundColor: TColors.buttonDisabled,
      disabledBackgroundColor: TColors.buttonDisabled,
      side: const BorderSide(color: TColors.primaryColor),
      padding: const EdgeInsets.symmetric(vertical: 18),
      textStyle: const TextStyle(fontSize: 16, color: TColors.textWhite, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}
