import 'package:flutter/material.dart';
import 'package:restaurant_frontend/features/authentication/screens/login/login.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    super.key,
    required bool isLastPage,
    required PageController controller,
    required this.dark,
  })  : _isLastPage = isLastPage,
        _controller = controller;

  final bool _isLastPage;
  final PageController _controller;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: TSizes.defaultSpace,
      bottom: TDeviceUtils.getBottomNavigationBarHeight(),
      child: _isLastPage
          ? ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
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
