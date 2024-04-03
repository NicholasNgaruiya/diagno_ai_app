import 'package:flutter/material.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';

class TSearchBar extends StatelessWidget {
  const TSearchBar({
    super.key,
    required this.text,
    this.icon,
    required this.backgroundColor,
    required this.borderColor,
    required this.textColor,
  });
  final String text;
  final IconData? icon;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: TDeviceUtils.getScreenWidth(context) * 0.9,
      height: 50,
      // padding: const EdgeInsets.all(TSizes.md),
      padding: const EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: textColor,
          ),
          const SizedBox(
            width: TSizes.spaceBtwItems,
          ),
          Text(
            text,
            style: TextStyle(color: textColor),
          ),
        ],
      ),
    );
  }
}
