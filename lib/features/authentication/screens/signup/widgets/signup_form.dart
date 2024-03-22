import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:restaurant_frontend/utils/validators/validation.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import 'terms_and_conditions_checkbox.dart';

class TSignupForm extends StatefulWidget {
  const TSignupForm({
    super.key,
    // required this.dark,
  });

  @override
  State<TSignupForm> createState() => _TSignupFormState();
}

class _TSignupFormState extends State<TSignupForm> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // final bool dark;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      // autovalidateMode: AutovalidateMode.always, // Enable auto validation
      child: Column(
        children: [
          //?firstname
          TextFormField(
            validator: (value) => TValidator.validateFirstName(value),
            controller: _firstNameController,
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
            controller: _lastNameController,
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
            controller: _emailController,
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
            controller: _passwordController,
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
            controller: _confirmPasswordController,
            validator: (value) => TValidator.validateConfirmPassword(value, _passwordController.text),
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
                if (_formKey.currentState!.validate()) {
                  print(_firstNameController.text);
                  print(_lastNameController.text);
                  print(_emailController.text);
                  print(_passwordController.text);
                  print(_confirmPasswordController.text);
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
