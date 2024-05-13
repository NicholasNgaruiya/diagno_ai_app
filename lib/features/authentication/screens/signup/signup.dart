import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/widgets/errors/custom_snackbar_content.dart';
import '../../../../data/authentication/blocs/signup/bloc/sign_up_bloc.dart';
import '../../../../utils/constants/colors.dart';
import '../../models/user_model.dart';
import 'widgets/signup_form.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: BlocListener<SignUpBloc, SignUpState>(
          listener: (context, state) {
            if (state is SignUpErrorState) {
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
            } else if (state is SignUpSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: CustomSnackBarContent(
                    snackBarTitle: 'Wohoo!',
                    snackBarSubtitle: 'Almost there ,verify your email',
                    backgroundColor: TColors.success,
                  ),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  // content: Text(TTexts.getAccountCreatedTitle),
                ),
              );
              //Handle success state by navigating to the next screen
              // Navigator.pushNamed(context, '/otp');
              Navigator.of(context).pushNamedAndRemoveUntil('/otp', (route) => false);
            }
          },
          child: BlocBuilder<SignUpBloc, SignUpState>(
            builder: (context, state) {
              if (state is SignUpLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: TColors.primaryColor,
                  ),
                );
              } else {
                return TSignupForm(
                  firstNameController: _firstNameController,
                  lastNameController: _lastNameController,
                  emailController: _emailController,
                  passwordController: _passwordController,
                  confirmPasswordController: _confirmPasswordController,
                  onSubmit: _submitForm,
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
    //Hendle form submission here
    if (_firstNameController.text.isNotEmpty &&
        _lastNameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _confirmPasswordController.text.isNotEmpty) {
      //dispatch a SignUpButtonClickedEvent with the form data
      BlocProvider.of<SignUpBloc>(context).add(
        SignUpButtonClickedEvent(
          UserModel(
            email: _emailController.text,
            firstName: _firstNameController.text,
            lastName: _lastNameController.text,
            password: _passwordController.text,
            password2: _confirmPasswordController.text,
          ),
        ),
      );
    }
  }
}
