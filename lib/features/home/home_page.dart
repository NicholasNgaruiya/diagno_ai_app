import 'package:diagno_ai_frontend/utils/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/helpers/helper_functions.dart';
import '../profile/widgets/get_username_widget.dart';
import 'health_tips_list.dart';
import 'horizontal_list_view.dart';
import 'quotes_widget.dart';
import 'theme_switcher_icon.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: darkMode ? TColors.black : TColors.white,
      appBar: AppBar(
        backgroundColor: darkMode ? TColors.black : TColors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello,',
                  style: TextStyle(
                    fontSize: 15,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w300,
                    color: darkMode ? TColors.white : TColors.black,
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
                  ],
                ),
              ],
            ),

            ///Theme Switcher icon
            ThemeSwitcherIcon(),
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
