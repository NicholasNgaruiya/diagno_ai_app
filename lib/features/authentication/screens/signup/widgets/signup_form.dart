import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import 'terms_and_conditions_checkbox.dart';

class TSignupForm extends StatelessWidget {
  const TSignupForm({
    super.key,
    // required this.dark,
  });

  // final bool dark;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          //?firstname
          TextFormField(
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
            child: ElevatedButton(onPressed: () {}, child: const Text(TTexts.createAccount)),
          ),
        ],
      ),
    );
  }
}
