import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_frontend/features/authentication/screens/login/login.dart';
import 'package:restaurant_frontend/features/authentication/screens/otpscreen/otp_screen.dart';
import 'package:restaurant_frontend/features/authentication/screens/signup/signup.dart';
import 'package:restaurant_frontend/utils/theme/theme.dart';

import 'data/authentication/services/authentication/signup/bloc/sign_up_bloc.dart';
import 'data/authentication/services/authentication/verify_email/bloc/verify_email_bloc.dart';
import 'features/authentication/screens/onboarding/onboarding.dart';

/// ---Class to setup themes,initial Bindings ,animations
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SignUpBloc(),
        ),
        BlocProvider(
          create: (context) => VerifyEmailBloc(),
        ),
      ],
      child: MaterialApp(
        themeMode: ThemeMode.system,
        theme: TAppTheme.lightTheme,
        darkTheme: TAppTheme.darkTheme,
        home: const OnBoardingScreen(),
        // home: const OtpScreen(),
        routes: {
          '/signup': (context) => const SignupScreen(),
          '/login': (context) => const LoginScreen(),
          '/otp': (context) => const OtpScreen(),
        },
      ),
    );
  }
}
