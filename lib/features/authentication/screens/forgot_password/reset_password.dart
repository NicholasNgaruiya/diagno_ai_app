import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
    // required this.textButtonName,
    required this.elevatedButtonName,
    required this.elevatedButtononPressed,
    // required this.textButtononPressed,
  });
  final String image, title, subTitle;
  final VoidCallback elevatedButtononPressed;
  // final VoidCallback textButtononPressed;
  // final String textButtonName;
  final String elevatedButtonName;

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: darkMode ? TColors.black : TColors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove the back arrow
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.close,
              size: 40,
              color: darkMode ? TColors.white : TColors.black,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              ///Image with 60% of screen width
              Image(image: AssetImage(image), width: THelperFunctions.screenWidth(context) * 0.6),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              /// Title & Subtitle
              Text(title, style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center),
              const SizedBox(height: TSizes.spaceBtwItems),
              Text(subTitle, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// Buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: elevatedButtononPressed,
                  child: Text(
                    elevatedButtonName,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),

              // SizedBox(
              //   width: double.infinity,
              //   child: TextButton(
              //     onPressed: textButtononPressed,
              //     child: Text(textButtonName, style: const TextStyle(color: Colors.black)),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
