import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:restaurant_frontend/features/authentication/screens/login/login.dart';
import 'package:restaurant_frontend/features/shop/customer/screens/widgets/get_username_widget.dart';
import 'package:restaurant_frontend/utils/constants/sizes.dart';
import 'package:restaurant_frontend/utils/device/device_utility.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/helper_functions.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: dark ? TColors.black : TColors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 150.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      // color: Colors.blue, // Background color of the app bar
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/products_images/felipe-vieira-PI3Jbv1hBlA-unsplash.jpg'),
                          fit: BoxFit.cover,
                        ),
                        // gradient: LinearGradient(
                        //   colors: [TColors.primaryColor, Colors.white],
                        // ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 70, // Half the height of the app bar
                      color: dark ? TColors.black : TColors.white, // Color for the lower half of the avatar
                    ),
                  ),
                  Positioned(
                    top: 60, // Half the height of the app bar
                    left: MediaQuery.of(context).size.width / 2 - 80,
                    // right: MediaQuery.of(context).size.width / 2,
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          // backgroundImage: AssetImage('assets/avatar.jpg'), // Replace 'assets/avatar.jpg' with your image path
                          backgroundImage: AssetImage(
                            'assets/images/products_images/christopher-campbell-rDEOVtE7vOs-unsplash.jpg',
                          ), // Replace 'assets/avatar.jpg' with your image path
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        GetUsernameWidget(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),

                ListTile(
                  leading: const Icon(Iconsax.user, size: 20, color: TColors.primaryColor),
                  title: const Text('My Profile'),
                  trailing: Icon(Icons.arrow_forward_ios, size: 18, color: dark ? TColors.white : TColors.black),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                ListTile(
                  leading: const Icon(Iconsax.information, size: 20, color: TColors.primaryColor),
                  title: const Text('Basic Information'),
                  trailing: Icon(Icons.arrow_forward_ios, size: 18, color: dark ? TColors.white : TColors.black),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                ListTile(
                  leading: const Icon(Iconsax.message, size: 20, color: TColors.primaryColor),
                  title: const Text('FeedBack and Support'),
                  trailing: Icon(Icons.arrow_forward_ios, size: 18, color: dark ? TColors.white : TColors.black),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwInputFields,
                ),
                ListTile(
                  leading: const Icon(Iconsax.key, size: 20, color: TColors.primaryColor),
                  title: const Text('Privacy and Security'),
                  trailing: Icon(Icons.arrow_forward_ios, size: 18, color: dark ? TColors.white : TColors.black),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                ListTile(
                  leading: const Icon(Iconsax.setting, size: 20, color: TColors.primaryColor),
                  title: const Text('Settings'),
                  trailing: Icon(Icons.arrow_forward_ios, size: 18, color: dark ? TColors.white : TColors.black),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Iconsax.logout, size: 20, color: TColors.error),
                  title: const Text(
                    'Log Out',
                    style: TextStyle(color: TColors.error),
                  ),
                  onTap: () {
                    //Navigate to logic screen
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                      (route) => false,
                    );
                  },
                ),

                // Add more list items as needed
              ],
            ),
          ),
        ],
      ),
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     // toolbarHeight: TSizes.appBarHeight,
    //     flexibleSpace: Container(
    //       decoration: const BoxDecoration(
    //         gradient: LinearGradient(
    //           colors: [TColors.primaryColor, Colors.white],
    //         ),
    //       ),
    //     ),
    //     title: const Padding(
    //       padding: EdgeInsets.only(left: 20.0),
    //       child: Text('Profile'),
    //     ),
    //   ),
    //   body: Center(
    //     child: Container(
    //       height: 150,
    //       width: 150,
    //       color: Colors.blue,
    //       child: Stack(
    //         children: [
    //           Positioned(
    //             left: 0,
    //             child: Container(
    //               width: 75,
    //               height: 150,
    //               color: Colors.white,
    //             ),
    //           ),
    //           Positioned(
    //             right: 0,
    //             child: Container(
    //               width: 75,
    //               height: 150,
    //               color: Colors.white,
    //             ),
    //           ),
    //           const Center(
    //             child: CircleAvatar(
    //               radius: 50,
    //               backgroundImage: AssetImage('assets/avatar.jpg'), // Replace 'assets/avatar.jpg' with your image path
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
