import 'package:flutter/material.dart';

class CustomSnackBarContent extends StatelessWidget {
  const CustomSnackBarContent({
    super.key,
    required this.snackBarTitle,
    required this.snackBarSubtitle,
    required this.backgroundColor,
  });
  final String snackBarTitle;
  final String snackBarSubtitle;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: 78,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 48,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  snackBarTitle,
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
                // const SizedBox(
                //   height: TSizes.spaceBtwItems,
                // ),
                // const Spacer(),
                Text(
                  snackBarSubtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
