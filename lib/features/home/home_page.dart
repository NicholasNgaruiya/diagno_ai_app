import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_frontend/data/home/bloc/home_bloc.dart';
import 'package:restaurant_frontend/features/home/app_details.dart';
import 'package:restaurant_frontend/features/home/quotes_widget.dart';
import 'package:restaurant_frontend/utils/constants/sizes.dart';
import 'package:restaurant_frontend/utils/device/device_utility.dart';

import '../../utils/constants/colors.dart';
import '../profile/widgets/get_username_widget.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.white,
      appBar: AppBar(
        backgroundColor: TColors.white,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello,',
              style: TextStyle(
                fontSize: 15,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w300,
                // color: ,
              ),
            ),
            Row(
              children: [
                GetUsernameWidget(),
                SizedBox(
                  width: 2,
                ),
                Text('!'),
                // Icon(Icons.search),
              ],
            ),
          ],
        ),
      ),
      body: const Column(
        children: [
          QuotesWidget(),
          SizedBox(
            height: TSizes.spaceBtwSections,
          ),
          AppDetailsList(),
        ],
      ),
    );
  }
}
