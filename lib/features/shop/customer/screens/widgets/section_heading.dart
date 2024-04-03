import 'package:flutter/material.dart';

class TSectionHeading extends StatelessWidget {
  const TSectionHeading({
    super.key,
    required this.headingTitle,
    this.buttonTitle = 'View All',
    required this.textColor,
    this.onPressed,
    required this.showActionButton,
  });
  final String headingTitle;
  final String buttonTitle;
  final Color textColor;
  final void Function()? onPressed;
  final bool showActionButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            headingTitle,
            style: Theme.of(context).textTheme.headlineSmall!.apply(color: textColor),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          if (showActionButton)
            TextButton(
              onPressed: () {},
              child: Text(buttonTitle),
            ),
        ],
      ),
    );
  }
}
