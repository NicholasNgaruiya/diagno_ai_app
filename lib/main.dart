import 'package:diagno_ai_frontend/utils/theme/theme_provider.dart';
import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'utils/constants/colors.dart';

int? initScreen;
Future<void> main() async {
  //TODO: Add Widgets
  WidgetsFlutterBinding.ensureInitialized();
  //TODO: Init Local Storage
  // initScreen = await TLocalStorage.getInt('initScreen') ?? 0;
  // bool rememberMe = await TLocalStorage.getBool('rememberMe') ?? false;
  // await TLocalStorage.saveInt('initScreen', 1);
  // print('initScreen $initScreen');
  //TODO: Await Native Splash Screen
  //TODO: Initialize Firebase
  //TODO: Initiliaze Authentication
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: BetterFeedback(
        //change theme
        theme: FeedbackThemeData(
          background: Colors.grey,
          feedbackSheetColor: Colors.grey[50]!,
          drawColors: [Colors.red, Colors.green, Colors.blue, Colors.yellow],
          bottomSheetTextInputStyle: const TextStyle(
            color: Colors.black,
          ),
          activeFeedbackModeColor: TColors.primaryColor,
          //change the decora
        ),
        child: const App(),
      ),
    ),
  );
}
