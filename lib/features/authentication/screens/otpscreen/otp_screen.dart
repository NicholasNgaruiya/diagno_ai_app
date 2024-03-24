import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant_frontend/utils/constants/sizes.dart';

import '../../../../utils/constants/text_strings.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  List<TextEditingController> controllers = List.generate(6, (index) => TextEditingController());

  @override
  void dispose() {
    // Dispose all controllers to avoid memory leaks
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  String getOtp() {
    return controllers.map((controller) => controller.text).join();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///Title
              Text(
                TTexts.verifyEmailTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              Text(
                TTexts.confirmEmailSubTitle,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              Form(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(6, (index) {
                    return SizedBox(
                      height: 48,
                      width: 44,
                      child: TextFormField(
                        controller: controllers[index],
                        onChanged: (value) {
                          if (value.length == 1) {
                            // Move focus to the next field
                            if (index < controllers.length - 1) {
                              FocusScope.of(context).nextFocus();
                            } else {
                              // If this is the last field, unfocus to dismiss the keyboard
                              FocusScope.of(context).unfocus();
                            }
                          }
                        },
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(
                height: TSizes.appBarHeight,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    String otp = getOtp();
                    // Now you can use the otp
                    print('OTP Entered: $otp');
                  },
                  child: const Text('Verify'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
