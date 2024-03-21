import 'package:flutter/material.dart';
import 'package:restaurant_frontend/features/authentication/screens/login/login.dart';
import 'package:restaurant_frontend/features/authentication/screens/onboarding/onboarding.dart';
import 'package:restaurant_frontend/features/authentication/screens/signup/signup.dart';
import 'package:restaurant_frontend/utils/theme/theme.dart';

/// ---Class to setup themes,initial Bindings ,animations
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      home: const OnBoardingScreen(),
      routes: {
        '/signup': (context) => const SignupScreen(),
        '/login': (context) => const LoginScreen(),
      },
    );
  }
}
