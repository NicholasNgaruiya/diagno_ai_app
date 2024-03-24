import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:restaurant_frontend/utils/validators/validation.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import 'terms_and_conditions_checkbox.dart';

class TSignupForm extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final VoidCallback onSubmit;

  const TSignupForm({
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.onSubmit,
    Key? key,
  }) : super(key: key);

  // final bool dark;
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
      // autovalidateMode: AutovalidateMode.always, // Enable auto validation
      child: Column(
        children: [
          //?firstname
          TextFormField(
            validator: (value) => TValidator.validateFirstName(value),
            controller: firstNameController,
            expands: false,
            decoration: const InputDecoration(
              labelText: TTexts.firstName,
              prefixIcon: Icon(Iconsax.user),
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          //?lastname
          TextFormField(
            controller: lastNameController,
            validator: (value) => TValidator.validateLastName(value),
            expands: false,
            decoration: const InputDecoration(
              labelText: TTexts.lastName,
              prefixIcon: Icon(Iconsax.user),
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          //?email
          TextFormField(
            controller: emailController,
            validator: (value) => TValidator.validateEmail(value),
            expands: false,
            decoration: const InputDecoration(
              labelText: TTexts.email,
              prefixIcon: Icon(Iconsax.direct),
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          //?password
          TextFormField(
            controller: passwordController,
            validator: (value) => TValidator.validatePassword(value),
            obscureText: true,
            expands: false,
            decoration: const InputDecoration(
              labelText: TTexts.password,
              prefixIcon: Icon(Iconsax.password_check),
              suffixIcon: Icon(Iconsax.eye_slash),
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          //? confirm password
          TextFormField(
            controller: confirmPasswordController,
            validator: (value) => TValidator.validateConfirmPassword(value, passwordController.text),
            obscureText: true,
            expands: false,
            decoration: const InputDecoration(
              labelText: TTexts.confirmPassword,
              prefixIcon: Icon(Iconsax.password_check),
              suffixIcon: Icon(Iconsax.eye_slash),
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),

          ///Terms&Conditions Checkbox
          const TTermsAndConditionsCheckbox(),
          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),

          ///Sign up button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  onSubmit();
                  print(firstNameController.text);
                  print(lastNameController.text);
                  print(emailController.text);
                  print(passwordController.text);
                  print(confirmPasswordController.text);
                }
              },
              child: const Text(TTexts.createAccount),
            ),
          ),
        ],
      ),
    );
  }
}
