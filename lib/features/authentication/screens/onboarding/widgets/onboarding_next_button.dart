import 'package:flutter/material.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../signup/signup.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    super.key,
    required bool isLastPage,
    required PageController controller,
  })  : _isLastPage = isLastPage,
        _controller = controller;

  final bool _isLastPage;
  final PageController _controller;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Positioned(
      right: TSizes.defaultSpace,
      bottom: TDeviceUtils.getBottomNavigationBarHeight(),
      child: _isLastPage
          ? ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignupScreen(),
                  ),
                );
              },
              child: const Text('Start'),
            )
          : ElevatedButton(
              onPressed: () {
                _controller.nextPage(duration: const Duration(milliseconds: 350), curve: Curves.easeIn);
              },
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                foregroundColor: dark ? Colors.white : Colors.black,
              ),
              child: const Icon(Icons.arrow_forward_ios),
            ),
    );
  }
}
