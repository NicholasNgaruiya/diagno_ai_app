import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';
import '../profile/widgets/get_username_widget.dart';
import 'health_tips_list.dart';
import 'horizontal_list_view.dart';
import 'quotes_widget.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.white,
      appBar: AppBar(
        backgroundColor: TColors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hello,',
              style: TextStyle(
                fontSize: 15,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w300,
                // color: ,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    GetUsernameWidget(),
                    SizedBox(
                      width: 2,
                    ),
                    Text('!'),
                    // Icon(Icons.search),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: const Icon(
                    Iconsax.user,
                    color: TColors.primaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: ListView(
        children: const [
          QuotesWidget(),
          SizedBox(
            height: TSizes.spaceBtwSections,
          ),
          // AppDetailsList(),
          // const HorizontalListView(),
          HorizontalScrollableList(),
          SizedBox(height: 20),
          // const Divider(
          //   indent: 10,
          //   endIndent: 10,
          // ),

          // Health Tips Section
          Center(
            child: Text(
              'Health Tips',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 10),
          // Flexible(
          //   child: ListView(
          //     shrinkWrap: true,
          //     children: const [
          //       HealthTipsList(), // Display a list of health tips
          //     ],
          //   ),
          // ),

          HealthTipsList(), // Display a list of health tips

          // const SizedBox(height: 20),
        ],
      ),
    );
  }
}
