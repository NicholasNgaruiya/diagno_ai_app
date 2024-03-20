import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';

class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({
    super.key,
    required this.dark,
    required PageController controller,
  }) : _controller = controller;

  final bool dark;
  final PageController _controller;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: TDeviceUtils.getBottomNavigationBarHeight() + 25,
      left: TSizes.defaultSpace,
      child: SmoothPageIndicator(
        effect: ExpandingDotsEffect(
          // activeDotColor: TColors.primaryColor,
          activeDotColor: TColors.primaryColor,
          dotColor: dark ? TColors.white : TColors.dark,
          dotHeight: 10,
          dotWidth: 10,
        ),
        onDotClicked: (index) => _controller.animateToPage(
          index,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeIn,
        ),
        controller: _controller,
        count: 3,
      ),

      ///Circular Button
      // const OnBoardingNextButton(),
    );
  }
}
