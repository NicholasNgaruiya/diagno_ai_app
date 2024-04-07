import 'package:flutter/material.dart';
import 'package:restaurant_frontend/utils/constants/sizes.dart';

import '../../../../utils/constants/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: TSizes.appBarHeight,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [TColors.primaryColor, Colors.white],
            ),
          ),
        ),
        title: const Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Text('Profile'),
        ),
      ),
    );
  }
}
