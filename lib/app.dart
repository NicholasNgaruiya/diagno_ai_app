import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_frontend/features/authentication/screens/forgot_password/forgot_password.dart';
import 'package:restaurant_frontend/features/authentication/screens/home/home.dart';
import 'package:restaurant_frontend/utils/theme/theme.dart';

import 'data/authentication/blocs/login/bloc/login_bloc.dart';
import 'data/authentication/blocs/signup/bloc/sign_up_bloc.dart';
import 'data/authentication/blocs/verify_email/bloc/verify_email_bloc.dart';
import 'features/authentication/screens/login/login.dart';
import 'features/authentication/screens/onboarding/onboarding.dart';
import 'features/authentication/screens/otpscreen/otp_screen.dart';
import 'features/authentication/screens/signup/signup.dart';

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
        BlocProvider(create: (context) => LoginBloc()),
      ],
      child: MaterialApp(
        themeMode: ThemeMode.system,
        theme: TAppTheme.lightTheme,
        darkTheme: TAppTheme.darkTheme,
        home: const OnBoardingScreen(),
        // home: const FlashMessageScreen(),
        // home: const OtpScreen(),
        routes: {
          '/signup': (context) => const SignupScreen(),
          '/login': (context) => const LoginScreen(),
          '/otp': (context) => const OtpScreen(),
          '/home': (context) => const HomeScreen(),
          '/forget_password': (context) => const ForgotPasswordScreen(),
        },
      ),
    );
  }
}
