import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/authentication/blocs/login/bloc/login_bloc.dart';
import 'data/authentication/blocs/profile/bloc/user_profile_bloc.dart';
import 'data/authentication/blocs/reset_password/bloc/reset_password_bloc.dart';
import 'data/authentication/blocs/signup/bloc/sign_up_bloc.dart';
import 'data/authentication/blocs/verify_email/bloc/verify_email_bloc.dart';
import 'data/diagnosis/bloc/diagnosis_bloc.dart';
import 'data/home/bloc/home_bloc.dart';
import 'data/shop/blocs/categories/bloc/categories_bloc.dart';
import 'data/shop/blocs/product/bloc/product_bloc.dart';
import 'features/authentication/screens/forgot_password/forgot_password.dart';
import 'features/authentication/screens/home/home.dart';
import 'features/authentication/screens/login/login.dart';
import 'features/authentication/screens/onboarding/onboarding.dart';
import 'features/authentication/screens/otpscreen/otp_screen.dart';
import 'features/authentication/screens/signup/signup.dart';
import 'features/bottom_navigation/navigation_menu.dart';
import 'features/shop/admin/screens/add_product/add_product_screen.dart';
import 'features/shop/admin/screens/categories/add_category_screeen.dart';
import 'features/shop/admin/screens/categories/new_categories_screen.dart';
import 'features/profile/profile_screen.dart';
import 'features/shop/admin/screens/dashboard/dashboard.dart';
import 'features/shop/admin/screens/edit_product.dart';
import 'features/shop/admin/screens/view_orders.dart';
import 'features/shop/customer/screens/widgets/demmo_screen.dart';
import 'utils/constants/colors.dart';
import 'utils/local_storage/storage_utility.dart';
import 'utils/theme/theme.dart';

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
        BlocProvider(create: (context) => ProductBloc()),
        BlocProvider(create: (context) => CategoriesBloc()),
        BlocProvider(create: (context) => HomeBloc()..add(FetchQuotesEvent())),
        BlocProvider(create: (context) => DiagnosisBloc()),
        BlocProvider(create: (context) => UserProfileBloc()),
        BlocProvider(create: (context) => ResetPasswordBloc()),
      ],
      // child: getInitialScreen(),
      child: FutureBuilder<String>(
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
            themeMode: ThemeMode.system,
            theme: TAppTheme.lightTheme,
            darkTheme: TAppTheme.darkTheme,
            // home: Dashboard(),
            // home: const OnBoardingScreen(),
            // initialRoute: initScreen == 0 || initScreen == null ? '/onboarding' : '/login',
            initialRoute: initialRoute,
            routes: {
              '/navigationBar': (context) => const NavigationMenu(),
              '/onboarding': (context) => const OnBoardingScreen(),
              '/signup': (context) => const SignupScreen(),
              '/login': (context) => const LoginScreen(),
              '/otp': (context) => const OtpScreen(),
              '/home': (context) => const HomeScreen(),
              '/forget_password': (context) => const ForgotPasswordScreen(),
              '/viewOrders': (context) => const ViewOrdersPage(),
              '/dashboard': (context) => const Dashboard(),
              '/addProducts': (context) => const AddProductsPage(),
              '/editProducts': (context) => const EditProductPage(),
              '/categoriesScreen': (context) => const CategoriesScreen(),
              '/addCategoryScreen': (context) => const AddCategoryPage(),
              '/demmmoPage': (context) => const DemmoWidget(),
              '/profileScreen': (context) => const ProfileScreen(),
              // '/profileDetailsScreen': (context) => const ProfileDetailsScreen(),

              // '/dashboard': (context) => const Dashboard(),
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
