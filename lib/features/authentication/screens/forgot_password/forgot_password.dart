import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/errors/custom_snackbar_content.dart';
import '../../../../data/authentication/blocs/reset_password/bloc/reset_password_bloc.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/validators/validation.dart';

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
      child: Scaffold(
        // appBar: AppBar(),
        body: BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
          listener: (context, state) {
            // TODO: implement listener
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
            } else if (state is ResetPasswordEmailSentState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: CustomSnackBarContent(
                    snackBarTitle: 'Wohoo!',
                    snackBarSubtitle: state.response['message'],
                    backgroundColor: TColors.success,
                  ),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  // content: Text(TTexts.getAccountCreatedTitle),
                ),
              );
              Navigator.of(context).pop();
            }
          },
          builder: (context, state) {
            if (state is ResetPasswordLoadingState) {
              return const Center(
                child: CircularProgressIndicator(
                  color: TColors.primaryColor,
                ),
              );
            } else {
              return SingleChildScrollView(
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
              );
            }
          },
        ),
      ),
    );
  }
}
