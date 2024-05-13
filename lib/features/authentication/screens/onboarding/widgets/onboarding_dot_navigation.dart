import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({
    super.key,
    required PageController controller,
  }) : _controller = controller;

  final PageController _controller;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Positioned(
      bottom: TDeviceUtils.getBottomNavigationBarHeight() + 140,
      // left: TSizes.defaultSpace,
      left: TDeviceUtils.getScreenWidth(context) * 0.4,
      child: SmoothPageIndicator(
        effect: ExpandingDotsEffect(
          // activeDotColor: TColors.primaryColor,
          activeDotColor: TColors.primaryColor,
          dotColor: dark ? TColors.darkGrey : TColors.darkGrey,
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
