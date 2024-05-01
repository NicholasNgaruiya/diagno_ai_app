import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:restaurant_frontend/features/authentication/screens/login/login.dart';
import 'package:restaurant_frontend/features/profile/widgets/get_username_widget.dart';
import 'package:restaurant_frontend/utils/constants/sizes.dart';
import 'package:restaurant_frontend/utils/device/device_utility.dart';
import 'package:restaurant_frontend/utils/local_storage/storage_utility.dart';

import '../../utils/constants/colors.dart';
import '../../utils/helpers/helper_functions.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool rememberMe = false;
  // bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    _loadRememberMe();

    // Future.delayed(const Duration(seconds: 10), () {
    //   setState(() {
    //     _isLoading = false;
    //   });
    // });
  }

  Future<void> _loadRememberMe() async {
    final rememberMeValue = await TLocalStorage.getBool('rememberMe') ?? false;
    setState(() {
      rememberMe = rememberMeValue;
    });
  }

  Future<void> _toggleRememberMe(bool newValue) async {
    setState(() {
      rememberMe = newValue;
    });
    await TLocalStorage.saveBool('rememberMe', newValue);
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: dark ? TColors.black : TColors.white,
      // body: _isLoading
      //     ? const Center(
      //         child: CircularProgressIndicator(
      //           color: TColors.primaryColor,
      //         ),
      //       )
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
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                ListTile(
                  leading: const Icon(Iconsax.setting, size: 20, color: TColors.primaryColor),
                  title: const Text('Remember Me'),
                  trailing: Switch(
                    value: rememberMe,
                    onChanged: _toggleRememberMe,
                    activeColor: TColors.primaryColor,
                    // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
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
  }
}
