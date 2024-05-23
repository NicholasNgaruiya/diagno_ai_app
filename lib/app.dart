import 'package:diagno_ai_frontend/utils/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'data/authentication/blocs/login/bloc/login_bloc.dart';
import 'data/authentication/blocs/profile/bloc/user_profile_bloc.dart';
import 'data/authentication/blocs/reset_password/bloc/reset_password_bloc.dart';
import 'data/authentication/blocs/signup/bloc/sign_up_bloc.dart';
import 'data/authentication/blocs/verify_email/bloc/verify_email_bloc.dart';
import 'data/diagnosis/bloc/diagnosis_bloc.dart';
import 'data/home/bloc/home_bloc.dart';
import 'features/authentication/screens/forgot_password/forgot_password.dart';
import 'features/authentication/screens/home/home.dart';
import 'features/authentication/screens/login/login.dart';
import 'features/authentication/screens/onboarding/onboarding.dart';
import 'features/authentication/screens/otpscreen/otp_screen.dart';
import 'features/authentication/screens/signup/signup.dart';
import 'features/bottom_navigation/navigation_menu.dart';
import 'features/profile/profile_screen.dart';

import 'utils/constants/colors.dart';
import 'utils/local_storage/storage_utility.dart';

/// ---Class to setup themes,initial Bindings ,animations
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SignUpBloc()),
        BlocProvider(create: (context) => VerifyEmailBloc()),
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => HomeBloc()..add(FetchQuotesEvent())),
        BlocProvider(create: (context) => DiagnosisBloc()),
        BlocProvider(create: (context) => UserProfileBloc()),
        BlocProvider(create: (context) => ResetPasswordBloc()),
      ],
      // child: getInitialScreen(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return FutureBuilder<String>(
            future: _getInitialRoute(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: TColors.primaryColor,
                  ),
                );
              }
              final initialRoute = snapshot.data;
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                // themeMode: ThemeMode.system,
                // theme: TAppTheme.lightTheme,
                // darkTheme: TAppTheme.darkTheme,

                theme: themeProvider.themeData,
                // themeMode: ThemeMode.system,
                initialRoute: initialRoute,
                routes: {
                  '/navigationBar': (context) => const NavigationMenu(),
                  '/onboarding': (context) => const OnBoardingScreen(),
                  '/signup': (context) => const SignupScreen(),
                  '/login': (context) => const LoginScreen(),
                  '/otp': (context) => const OtpScreen(),
                  '/home': (context) => const HomeScreen(),
                  '/forget_password': (context) => const ForgotPasswordScreen(),
                  '/profileScreen': (context) => const ProfileScreen(),
                },
              );
            },
          );
        },
      ),
    );
  }
}

Future<String> _getInitialRoute() async {
  int? initScreen = await TLocalStorage.getInt('initScreen') ?? 0;
  bool rememberMe = await _getRememberMeValue();
  await TLocalStorage.saveInt('initScreen', 1);
  print('initScreen $initScreen');
  if (initScreen == 0) {
    return '/onboarding';
  } else if (rememberMe == true) {
    return '/navigationBar';
  } else {
    return '/login';
  }
}

Future<bool> _getRememberMeValue() async {
  bool rememberMe = await TLocalStorage.getBool('rememberMe') ?? false;
  return rememberMe;
}
