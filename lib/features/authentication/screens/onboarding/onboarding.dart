import 'package:flutter/material.dart';

import 'package:restaurant_frontend/utils/constants/image_strings.dart';
import 'package:restaurant_frontend/utils/constants/text_strings.dart';

import 'package:restaurant_frontend/utils/helpers/helper_functions.dart';

import 'widgets/onboarding_dot_navigation.dart';
import 'widgets/onboarding_next_button.dart';
import 'widgets/onboarding_page.dart';
import 'widgets/onboarding_skip.dart';

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

          ///Dot Navigation
          OnBoardingDotNavigation(dark: dark, controller: _controller),

          ///Skip Button
          OnBoardingSkip(controller: _controller, pages: pages),

          ///Next Button
          OnBoardingNextButton(isLastPage: _isLastPage, controller: _controller, dark: dark),
        ],
      ),
    );
  }
}
