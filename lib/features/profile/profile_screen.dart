import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:iconsax/iconsax.dart';
import 'package:path_provider/path_provider.dart';

import '../../data/authentication/blocs/profile/bloc/user_profile_bloc.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/device/device_utility.dart';
import '../../utils/helpers/helper_functions.dart';
import '../../utils/local_storage/storage_utility.dart';
import '../authentication/screens/login/login.dart';
import 'update_profile_screen.dart';
import 'widgets/get_email_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool rememberMe = false;
  String? _avatarImagePath; // Added variable to hold the image path
  // bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    _loadRememberMe();
    _loadAvatarImage();
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

  Future<void> _loadAvatarImage() async {
    final avatarImagePath = await TLocalStorage.getString('image_path');
    setState(() {
      _avatarImagePath = avatarImagePath;
    });
  }

  // Function to get the image widget, with a default image if _avatarImagePath is null
  Widget _getAvatarImageWidget() {
    if (_avatarImagePath != null) {
      return Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: TColors.primaryColor,
          ),
        ),
        child: ClipOval(
          child: CachedNetworkImage(
            imageUrl: _avatarImagePath!,
            width: 100, // Adjust width and height as needed
            height: 100,
            fit: BoxFit.cover, // Specify the fit property
          ),
        ),
      );
    } else {
      return Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          // color: TColors.primaryColor.withOpacity(0.2),

          border: Border.all(
            color: TColors.primaryColor,
          ),
          image: DecorationImage(
            image: AssetImage(
              'assets/images/profile/default_profile_photo-removebg-preview.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
      );
    }
  }

  Future<String> _writeScreenshotToStorage(Uint8List screenshot) async {
    final directory = await getTemporaryDirectory();
    final filePath = '${directory.path}/feedback.png';
    final file = File(filePath);

    await file.writeAsBytes(screenshot);
    return filePath;
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: dark ? TColors.black : TColors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 132.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Positioned.fill(
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://images.unsplash.com/photo-1488866022504-f2584929ca5f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NDd8fHNreXxlbnwwfHwwfHx8MA%3D%3D',
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(
                          color: TColors.primaryColor,
                        ),
                      ),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 50, // Half the height of the app bar
                      color: dark ? TColors.black : TColors.white, // Color for the lower half of the avatar
                    ),
                  ),
                  Positioned(
                    top: 65, // Half the height of the app bar
                    left: MediaQuery.of(context).size.width / 2 - 50,
                    // right: MediaQuery.of(context).size.width / 2,
                    child: _getAvatarImageWidget(),

                    // const GetUsernameWidget(),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const SizedBox(
                  height: 8,
                ),
                const Center(child: GetEmailWidget()),

                const SizedBox(
                  height: TSizes.spaceBtwSections - 10,
                ),

                ListTile(
                  leading: const Icon(Iconsax.user, size: 20, color: TColors.primaryColor),
                  title: const Text('My Profile'),
                  trailing: Icon(Icons.arrow_forward_ios, size: 18, color: dark ? TColors.white : TColors.black),
                  onTap: () {
                    //Navigate to update profile screen
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const UpdateProfileScreen(),
                      ),
                    );
                    //Add fetch user profile event
                    BlocProvider.of<UserProfileBloc>(context).add(FetchUserProfile());
                  },
                ),

                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                ListTile(
                  leading: const Icon(Iconsax.message, size: 20, color: TColors.primaryColor),
                  title: const Text('Give Feedback'),
                  trailing: Icon(Icons.arrow_forward_ios, size: 18, color: dark ? TColors.white : TColors.black),
                  onTap: () => BetterFeedback.of(context).show(
                    (UserFeedback feedback) async => FlutterEmailSender.send(
                      Email(
                        attachmentPaths: [
                          await _writeScreenshotToStorage(feedback.screenshot),
                        ],
                        body: feedback.text,
                        recipients: ['nicholas.ngaruiya.dev@gmail.com'],
                        subject: feedback.text.split(' ').take(7).toList().join(''),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwInputFields,
                ),
                ListTile(
                  leading: const Icon(Iconsax.key, size: 20, color: TColors.primaryColor),
                  title: const Text('Privacy Policy'),
                  trailing: Icon(Icons.arrow_forward_ios, size: 18, color: dark ? TColors.white : TColors.black),
                  onTap: () {
                    TDeviceUtils.launchUrl('https://www.privacypolicies.com/live/b63728cd-09a1-48fa-8a4a-d99b1def6d49');
                  },
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                ListTile(
                  leading: const Icon(Iconsax.information, size: 20, color: TColors.primaryColor),
                  title: const Text('Terms and Conditions'),
                  trailing: Icon(Icons.arrow_forward_ios, size: 18, color: dark ? TColors.white : TColors.black),
                  onTap: () {
                    TDeviceUtils.launchUrl('https://www.privacypolicies.com/live/966d15d7-3da1-41c6-ba67-47c6b78d16cb');
                  },
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
                const Divider(
                  indent: 15,
                  endIndent: 15,
                ),
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
                // display version number of the app
                const ListTile(
                  title: Text('Version 2.2.0'),
                  dense: true,
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
