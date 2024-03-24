import 'package:flutter/material.dart';
import 'package:restaurant_frontend/utils/constants/sizes.dart';
import 'package:restaurant_frontend/utils/device/device_utility.dart';

import 'onboarding_page.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
    required PageController controller,
    required this.pages,
  }) : _controller = controller;

  final PageController _controller;
  final List<OnBoardingPage> pages;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: TDeviceUtils.getAppBarHeight(context),
      right: TSizes.defaultSpace,
      child: TextButton(
        onPressed: () {
          _controller.jumpToPage(pages.length);
        },
        child: const Text('Skip'),
      ),
    );
  }
}