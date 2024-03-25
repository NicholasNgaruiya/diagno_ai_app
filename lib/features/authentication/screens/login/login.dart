import 'package:flutter/material.dart';
import 'package:restaurant_frontend/common/styles/spacing_styles.dart';

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

  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              ///Logo,Title,Subttitle
              TLoginHeader(),

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
      ),
    );
  }

  void _submitForm() {
    print('Button Clicked');
    if (_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
      //Handle form submission here
    }
  }
}
