import 'package:diagno_ai_frontend/utils/device/device_utility.dart';
import 'package:diagno_ai_frontend/utils/local_storage/storage_utility.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class TTermsAndConditionsCheckbox extends StatefulWidget {
  final ValueChanged<bool>? onChanged;
  final String? errorText;

  const TTermsAndConditionsCheckbox({
    super.key,
    this.onChanged,
    this.errorText,
  });

  @override
  State<TTermsAndConditionsCheckbox> createState() => _TTermsAndConditionsCheckboxState();
}

class _TTermsAndConditionsCheckboxState extends State<TTermsAndConditionsCheckbox> {
  bool agreedToTerms = false;
  // bool termsValidationError = false;
  @override
  void initState() {
    super.initState();
    _checkAgreementStatus();
  }

  Future<void> _checkAgreementStatus() async {
    bool storedAgreementStatus = await TLocalStorage.getBool('agreed_to_terms') ?? false;
    setState(() {
      agreedToTerms = storedAgreementStatus;
    });
  }

  Future<void> _updateAgreementStatus(bool value) async {
    if (!mounted) return;
    await TLocalStorage.saveBool('agreed_to_terms', value);
    if (mounted) {
      setState(() {
        agreedToTerms = value;
        // termsValidationError = false; //Reset validation error when the checkbox state changes
      });
    }
  }

  // //New validation function for the checkbox
  // bool _validateCheckbox() {
  //   if (!agreedToTerms) {
  //     setState(() {
  //       termsValidationError = true;
  //     });
  //     return false; //Validation failed
  //   }
  //   return true; //Validation passed
  // }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return FormField<bool>(
      initialValue: agreedToTerms,
      validator: (value) {
        print('validator value $value');
        if (value == false || value == null) {
          return widget.errorText ?? 'Please agree to the terms before proceeding';
        }
        return null;
      },
      builder: (state) {
        print('Error Text: ${state.errorText}');
        return Row(
          children: [
            SizedBox(
              width: 40,
              height: 40,
              child: Checkbox(
                value: agreedToTerms,
                onChanged: (value) {
                  if (widget.onChanged != null) widget.onChanged!(value!);

                  print('value: $value');
                  if (value != null) {
                    _updateAgreementStatus(value);
                    state.didChange(value);
                  }
                },
              ),
            ),
            if (state.hasError) //display error message if validation fails

              Text(
                state.errorText!,
                style: TextStyle(color: TColors.error),
              ),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            Flexible(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: '${TTexts.iAgreeTo} ', style: Theme.of(context).textTheme.bodySmall),
                    TextSpan(
                      text: '${TTexts.privacyPolicy} ',
                      style: Theme.of(context).textTheme.bodySmall!.apply(
                            color: dark ? TColors.primaryColor : TColors.primaryColor,
                            decoration: TextDecoration.underline,
                            decorationColor: dark ? TColors.primaryColor : TColors.primaryColor,
                          ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          TDeviceUtils.launchUrl('https://www.privacypolicies.com/live/b63728cd-09a1-48fa-8a4a-d99b1def6d49');
                        },
                    ),
                    TextSpan(text: '${TTexts.and} ', style: Theme.of(context).textTheme.bodySmall),
                    TextSpan(
                      text: '${TTexts.termsOfService} ',
                      style: Theme.of(context).textTheme.bodySmall!.apply(
                            color: dark ? TColors.primaryColor : TColors.primaryColor,
                            decoration: TextDecoration.underline,
                            decorationColor: dark ? TColors.primaryColor : TColors.primaryColor,
                          ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          TDeviceUtils.launchUrl('https://www.privacypolicies.com/live/966d15d7-3da1-41c6-ba67-47c6b78d16cb');
                        },
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
