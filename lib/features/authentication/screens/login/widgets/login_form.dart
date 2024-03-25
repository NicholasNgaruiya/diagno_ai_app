import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/validators/validation.dart';

class TLoginForm extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onSubmit;
  const TLoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.onSubmit,
  });

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
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
        child: Column(
          children: [
            //Email
            TextFormField(
              controller: widget.emailController,
              validator: (value) => TValidator.validateEmail(value),
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
                    Checkbox(value: true, onChanged: (value) {}),
                    const Text(
                      TTexts.rememberMe,
                    ),
                  ],
                ),
                TextButton(onPressed: () {}, child: const Text(TTexts.forgetPasswordTitle)),
              ],
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),

            ///Sign In Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    widget.onSubmit();
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
