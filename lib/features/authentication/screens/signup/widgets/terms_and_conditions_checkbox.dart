import 'package:flutter/material.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class TTermsAndConditionsCheckbox extends StatelessWidget {
  const TTermsAndConditionsCheckbox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Row(
      children: [
        SizedBox(
          width: 40,
          height: 40,
          child: Checkbox(
            value: true,
            onChanged: (value) {},
          ),
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
                ),
                TextSpan(text: '${TTexts.and} ', style: Theme.of(context).textTheme.bodySmall),
                TextSpan(
                  text: '${TTexts.termsOfService} ',
                  style: Theme.of(context).textTheme.bodySmall!.apply(
                        color: dark ? TColors.primaryColor : TColors.primaryColor,
                        decoration: TextDecoration.underline,
                        decorationColor: dark ? TColors.primaryColor : TColors.primaryColor,
                      ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
