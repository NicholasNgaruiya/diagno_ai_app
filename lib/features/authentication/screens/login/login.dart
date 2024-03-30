import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_frontend/common/styles/spacing_styles.dart';
import 'package:restaurant_frontend/data/authentication/blocs/login/bloc/login_bloc.dart';

import '../../../../common/widgets/errors/custom_snackbar_content.dart';
import '../../../../utils/constants/colors.dart';
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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final dark = THelperFunctions.isDarkMode(context);
    return SafeArea(
      child: Scaffold(
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
              Navigator.of(context).pushReplacementNamed('/dashboard');
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
                        ),

                        ///Divider
                        // TFormDivider(dividerText: TTexts.orSignInWith),
                        // SizedBox(
                        //   height: TSizes.spaceBtwItems,
                        // ),

                        // ///Footer
                        // ///Row
                        // TSocialButtons(),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    print('Button Clicked');
    if (_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
      //Handle form submission here
      BlocProvider.of<LoginBloc>(context).add(
        LoginButtonClickedEvent(email: _emailController.text, password: _passwordController.text),
      );
    }
  }
}
