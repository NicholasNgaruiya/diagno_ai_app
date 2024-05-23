import 'package:diagno_ai_frontend/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/constants/colors.dart';
import '../../utils/helpers/helper_functions.dart';
import '../../utils/theme/theme_provider.dart';

class ThemeSwitcherIcon extends StatelessWidget {
  const ThemeSwitcherIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);

    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return IconButton(
            onPressed: () {
              themeProvider.togglTheme();
            },
            icon: Icon(
              themeProvider.themeData == TAppTheme.lightTheme ? Icons.sunny : Icons.nightlight_round,
              color: darkMode ? TColors.white : TColors.black,
            ),
          );
        },
      ),
    );
  }
}
