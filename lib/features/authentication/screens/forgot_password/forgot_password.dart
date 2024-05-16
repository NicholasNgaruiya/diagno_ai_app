import 'package:diagno_ai_frontend/features/authentication/screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/errors/custom_snackbar_content.dart';
import '../../../../data/authentication/blocs/reset_password/bloc/reset_password_bloc.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/validators/validation.dart';
import 'reset_password.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return SafeArea(
      child: BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
        listener: (context, state) {
          if (state is ResetPasswordFailureState) {
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
          }
        },
        builder: (context, state) {
          if (state is ResetPasswordLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: TColors.primaryColor,
              ),
            );
          } else if (state is ResetPasswordEmailSentState) {
            return ResetPassword(
              image: 'assets/images/on_boarding_images/sammy-line-42.png',
              title: TTexts.changeYourPasswordTitle,
              subTitle: TTexts.changeYourPasswordSubTitle,
              elevatedButtonName: 'Done',
              // textButtonName: 'Resend Email',
              elevatedButtononPressed: () {
                Navigator.of(context).pop();
              },
              // textButtononPressed: () {
              //   //Navigate to the login screen using material page route
              //   Navigator.pushAndRemoveUntil(
              //     context,
              //     MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
              //     (route) => false,
              //   );
              // },
            );
          } else {
            return Scaffold(
              appBar: AppBar(),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(TSizes.defaultSpace),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        TTexts.forgetPasswordTitle,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      Text(
                        TTexts.forgetPasswordSubTitle,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwSections,
                      ),
                      Form(
                        key: formKey,
                        child: //?email
                            Column(
                          children: [
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
                              height: TSizes.appBarHeight,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    //Add the ResetPasswordButtonClicked event
                                    BlocProvider.of<ResetPasswordBloc>(context)
                                        .add(ResetPasswordButtonClicked(email: _emailController.text));

                                    print('Continue button clicked');
                                  }
                                },
                                child: const Text(
                                  'Continue',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
