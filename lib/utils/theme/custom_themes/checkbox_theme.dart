import 'package:flutter/material.dart';
import 'package:restaurant_frontend/utils/constants/colors.dart';

class TCheckboxTheme {
  TCheckboxTheme._();

  ///Customizable Light Checkbox theme
  static CheckboxThemeData lightCheckboxTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    checkColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return Colors.white;
      } else {
        return Colors.black;
      }
    }),
    fillColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return TColors.primaryColor;
      } else {
        return Colors.transparent;
      }
    }),
  );

  ///Customizable Light Checkbox theme
  static CheckboxThemeData darkCheckboxTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    checkColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return Colors.white;
      } else {
        return Colors.black;
      }
    }),
    fillColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return TColors.primaryColor;
      } else {
        return Colors.transparent;
      }
    }),
  );

  // ///Customizable Dark Checkbox theme
  // static CheckboxThemeData darkCheckboxTheme = CheckboxThemeData(
  //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  //   checkColor: MaterialStateProperty.resolveWith((states) {
  //     if (states.contains(MaterialState.selected)) {
  //       return Colors.white;
  //     } else {
  //       return Colors.black;
  //     }
  //   }),
  //   fillColor: MaterialStateProperty.resolveWith((states) {
  //     if (states.contains(MaterialState.selected)) {
  //       return TColors.primaryColor;
  //     } else {
  //       return Colors.transparent;
  //     }
  //   }),
  // );
}
