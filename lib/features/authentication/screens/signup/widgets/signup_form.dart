import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/validators/validation.dart';
import 'terms_and_conditions_checkbox.dart';

class TSignupForm extends StatefulWidget {
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

  @override
  State<TSignupForm> createState() => _TSignupFormState();
}

class _TSignupFormState extends State<TSignupForm> {
  late bool _passwordVisible;
  late bool _confirmPasswordVisible;

  @override
  void initState() {
    _passwordVisible = false;
    _confirmPasswordVisible = false;
    super.initState();
  }

  // final bool dark;
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///Title
            Text(
              TTexts.signUpTitle,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            Form(
              key: formKey,
              // autovalidateMode: AutovalidateMode.always, // Enable auto validation
              child: Column(
                children: [
                  //?firstname
                  TextFormField(
                    validator: (value) => TValidator.validateFirstName(value),
                    controller: widget.firstNameController,
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
                    controller: widget.lastNameController,
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
                    controller: widget.emailController,
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
                    controller: widget.passwordController,
                    validator: (value) => TValidator.validatePassword(value),
                    obscureText: !_passwordVisible, //This will obscure text dynamically
                    expands: false,
                    decoration: InputDecoration(
                      labelText: TTexts.password,
                      prefixIcon: const Icon(Iconsax.password_check),
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
                    ),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwInputFields,
                  ),
                  //? confirm password
                  TextFormField(
                    controller: widget.confirmPasswordController,
                    validator: (value) => TValidator.validateConfirmPassword(value, widget.passwordController.text),
                    obscureText: !_confirmPasswordVisible,
                    expands: false,
                    decoration: InputDecoration(
                      labelText: TTexts.confirmPassword,
                      prefixIcon: const Icon(Iconsax.password_check),
                      // suffixIcon: Icon(Iconsax.eye_slash,),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _confirmPasswordVisible = !_confirmPasswordVisible;
                          });
                        },
                        icon: Icon(
                          _confirmPasswordVisible ? Iconsax.eye : Iconsax.eye_slash,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),

                  //TODO:Terms&Conditions Checkbox
                  // const TTermsAndConditionsCheckbox(),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),

                  ///Sign up button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          widget.onSubmit();
                          print(widget.firstNameController.text);
                          print(widget.lastNameController.text);
                          print(widget.emailController.text);
                          print(widget.passwordController.text);
                          print(widget.confirmPasswordController.text);
                        }
                      },
                      child: const Text(
                        TTexts.createAccount,
                        style: TextStyle(color: TColors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),

                  ///Divider
                  // const TFormDivider(dividerText: TTexts.orSignUpWith),
                  // const SizedBox(
                  //   height: TSizes.spaceBtwItems,
                  // ),
                  // const TSocialButtons(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
