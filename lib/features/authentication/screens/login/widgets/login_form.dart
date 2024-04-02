import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/validators/validation.dart';

class TLoginForm extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onSubmit;
  final bool rememberMe;
  final Function(bool) onRememberMe;
  const TLoginForm({
    Key? key,
    required this.emailController,
    required this.passwordController,
    required this.onSubmit,
    required this.rememberMe,
    required this.onRememberMe,
  }) : super(key: key);

  @override
  State<TLoginForm> createState() => _TLoginFormState();
}

class _TLoginFormState extends State<TLoginForm> {
  late bool _passwordVisible;

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
        child: Column(
          children: [
            //Email
            TextFormField(
              validator: (value) => TValidator.validateEmail(value),
              controller: widget.emailController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct),
                labelText: TTexts.email,
                // hintText: TTexts.email,
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),
            //Password
            TextFormField(
              controller: widget.passwordController,
              validator: (value) => TValidator.validatePassword(value),
              obscureText: !_passwordVisible,
              decoration: InputDecoration(
                prefixIcon: const Icon(Iconsax.password_check),
                labelText: TTexts.password,
                // suffixIcon: Icon(Iconsax.eye_slash,),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                  icon: Icon(
                    _passwordVisible ? Iconsax.eye : Iconsax.eye_slash,
                  ),
                ),
                // hintText: TTexts.email,
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields / 2,
            ),

            ///Remember me and Forgot Password
            ///Remember me
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: widget.rememberMe,
                      onChanged: (newValue) {
                        print(newValue);
                        widget.onRememberMe(newValue ?? false);
                      },
                    ),
                    const Text(
                      TTexts.rememberMe,
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/forget_password');
                  },
                  child: const Text(TTexts.forgetPasswordTitle),
                ),
              ],
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),

            ///?Sign In Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  print('Login button clicked');
                  if (formKey.currentState!.validate()) {
                    widget.onSubmit();
                    print(widget.emailController.text);
                    print(widget.passwordController.text);
                  }
                },
                child: const Text(TTexts.signIn),
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),

            ///Create Account Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  //navigate to the signupScreen
                  Navigator.pushNamed(context, '/signup');
                },
                child: const Text(TTexts.createAccount),
              ),
            ),

            ///Password
          ],
        ),
      ),
    );
  }
}
