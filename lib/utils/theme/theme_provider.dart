import 'package:diagno_ai_frontend/utils/theme/theme.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  late ThemeData _themeData;
  ThemeProvider() {
    //Initialize theme based on system's default theme mode
    _themeData =
        WidgetsBinding.instance.window.platformBrightness == Brightness.dark ? TAppTheme.darkTheme : TAppTheme.lightTheme;
  }
  // ThemeData _themeData = TAppTheme.lightTheme;

  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void togglTheme() {
    if (_themeData == TAppTheme.lightTheme) {
      _themeData = TAppTheme.darkTheme;
    } else {
      _themeData = TAppTheme.lightTheme;
    }
    notifyListeners();
  }
}
