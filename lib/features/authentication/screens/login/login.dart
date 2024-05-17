import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/styles/spacing_styles.dart';
import '../../../../common/widgets/errors/custom_snackbar_content.dart';
import '../../../../data/authentication/blocs/login/bloc/login_bloc.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/local_storage/storage_utility.dart';
import 'widgets/login_form.dart';
import 'widgets/login_header.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _loadRememberMeValue(); //load rememberMe value  and saved credentials from local storage
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _loadRememberMeValue() async {
    bool? savedValue = await TLocalStorage.getBool('rememberMe');
    print('new bool is $savedValue');
    setState(() {
      _rememberMe = savedValue ?? false;
    });
    if (_rememberMe) {
      _loadSavedCredentials();
    }
  }

  void _loadSavedCredentials() async {
    //Load saved email and password
    final savedEmail = await TLocalStorage.getString('email');
    final savedPassword = await TLocalStorage.getString('password');

    if (savedEmail != null && savedPassword != null) {
      setState(() {
        _emailController.text = savedEmail;
        _passwordController.text = savedPassword;
      });
    }
  }

  void _toggleRememberMe(bool newValue) async {
    setState(() {
      _rememberMe = newValue;
    });
    if (newValue) {
      //if the checkbox is checked ,save the value to local storage
      await TLocalStorage.saveBool('rememberMe', newValue);
    } else {
      //Implement logic to clear saved,rememberMe email and password from local storage
      await TLocalStorage.remove('rememberMe');
      await TLocalStorage.remove('email');
      await TLocalStorage.remove('password');
    }
  }

  @override
  Widget build(BuildContext context) {
    // final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: TColors.white,
      appBar: AppBar(
        backgroundColor: TColors.white,
      ),
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            //Handle failure state by showing a snack bar with the error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                // content: Text(state.error.toString()),
                content: CustomSnackBarContent(
                  snackBarTitle: 'Oops!',
                  snackBarSubtitle: state.error.toString(),
                  // snackBarSubtitle: TTexts.emailAlreadyExistsError,
                  backgroundColor: TColors.error,
                ),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
            );
            // print('This is the error:${state.error.toString()}');
          } else if (state is LoginSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: CustomSnackBarContent(
                  snackBarTitle: 'Wohoo!',
                  snackBarSubtitle: 'Welcome to the app!',
                  backgroundColor: TColors.success,
                ),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
                elevation: 0,
                // content: Text(TTexts.getAccountCreatedTitle),
              ),
            );
            //Handle success state by navigating to the next screen
            // Navigator.of(context).pushReplacementNamed('/dashboard');
            Navigator.of(context).pushReplacementNamed('/navigationBar');
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            if (state is LoginLoadingState) {
              return const Center(
                child: CircularProgressIndicator(
                  color: TColors.primaryColor,
                ),
              );
            } else {
              return SingleChildScrollView(
                child: Padding(
                  padding: TSpacingStyle.paddingWithAppBarHeight,
                  child: Column(
                    children: [
                      ///Logo,Title,Subttitle
                      const TLoginHeader(),

                      ///Form
                      TLoginForm(
                        emailController: _emailController,
                        passwordController: _passwordController,
                        onSubmit: _submitForm,
                        rememberMe: _rememberMe,
                        onRememberMe: _toggleRememberMe,
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  void _submitForm() {
    print('Button Clicked');
    print(_emailController.text);
    print(_passwordController.text);
    if (_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
      //Handle form submission here
      BlocProvider.of<LoginBloc>(context).add(
        LoginButtonClickedEvent(email: _emailController.text, password: _passwordController.text),
      );
    }
  }
}
