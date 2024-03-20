import 'package:flutter/material.dart';
import 'package:restaurant_frontend/features/authentication/screens.onboarding/home_demmo1.dart';

import 'package:restaurant_frontend/utils/constants/image_strings.dart';
import 'package:restaurant_frontend/utils/constants/text_strings.dart';

import 'package:restaurant_frontend/utils/constants/colors.dart';
import 'package:restaurant_frontend/utils/constants/sizes.dart';
import 'package:restaurant_frontend/utils/device/device_utility.dart';
import 'package:restaurant_frontend/utils/helpers/helper_functions.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'widgets/onboarding_page.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final _controller = PageController();
  late bool _isLastPage;

  final pages = [
    const OnBoardingPage(
      image: TImages.onBoardingImage1,
      title: TTexts.onBoardingTitle1,
      subTitle: TTexts.onBoardingSubtitle1,
    ),
    const OnBoardingPage(
      image: TImages.onBoardingImage2,
      title: TTexts.onBoardingTitle2,
      subTitle: TTexts.onBoardingSubtitle2,
    ),
    const OnBoardingPage(
      image: TImages.onBoardingImage3,
      title: TTexts.onBoardingTitle3,
      subTitle: TTexts.onBoardingSubtitle3,
    ),
  ];

  @override
  void initState() {
    _isLastPage = false;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      body: Stack(
        children: [
          ///Horizontal Scrollable Pages
          PageView(
            controller: _controller,
            children: pages,
            onPageChanged: (index) {
              setState(() {
                _isLastPage = index == pages.length - 1;
              });
            },
          ),

          ///Skip Button
          // const OnBoardingSkip(),

          ///Dot Navigation SmoothPageIndicator
          // const OnBoardingDotNavigation(),
          Positioned(
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
          ),

          ///Skip Button
          //?   const OnBoardingSkip(),
          Positioned(
            top: TDeviceUtils.getAppBarHeight(context),
            right: TSizes.defaultSpace,
            child: TextButton(
              onPressed: () {
                _controller.jumpToPage(pages.length);
              },
              child: const Text('Skip'),
            ),
          ),

          //?   const OnBoardingNextButton(),
          Positioned(
            right: TSizes.defaultSpace,
            bottom: TDeviceUtils.getBottomNavigationBarHeight(),
            child: _isLastPage
                ? ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeDemmo1(),
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
          ),
        ],
      ),
    );
  }
}
