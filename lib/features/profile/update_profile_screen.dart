import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/widgets/dashboard/image_selector.dart';
import '../../common/widgets/errors/custom_snackbar_content.dart';
import '../../data/authentication/blocs/profile/bloc/user_profile_bloc.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/device/device_utility.dart';
import '../../utils/helpers/helper_functions.dart';
import 'models/update_profile_model.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  File? selectedImage;
  String? imageUrl;

  @override
  void dispose() {
    super.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: darkMode ? TColors.black : TColors.white,
      appBar: AppBar(
        title: Text('Update Profile', style: TextStyle(color: darkMode ? TColors.white : TColors.black)),
        backgroundColor: darkMode ? TColors.black : TColors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: darkMode ? TColors.white : TColors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: BlocConsumer<UserProfileBloc, UserProfileState>(
        listener: (context, state) {
          if (state is UserProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: CustomSnackBarContent(
                  snackBarTitle: 'Oops!',
                  snackBarSubtitle: state.message,
                  backgroundColor: TColors.error,
                ),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
            );
            // Navigator.of(context).pop();
          } else if (state is UserProfileUpdated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: CustomSnackBarContent(
                  snackBarTitle: 'Success!',
                  snackBarSubtitle: 'Profile updated successfully',
                  backgroundColor: TColors.success,
                ),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
            );
            Navigator.of(context).pop();
            BlocProvider.of<UserProfileBloc>(context).add(FetchUserProfile());
          }
        },
        builder: (context, state) {
          if (state is UserProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: TColors.primaryColor,
              ),
            );
          } else if (state is UserProfileLoaded) {
            _firstNameController.text = state.fetchProfileModel.firstName;
            _lastNameController.text = state.fetchProfileModel.lastName;
            _emailController.text = state.fetchProfileModel.email;
            // imageUrl = state.fetchProfileModel.image;

            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(left: 14.0, right: 12.0, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add Image',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: darkMode ? TColors.white : TColors.black),
                    ),
                    const SizedBox(height: 10),
                    ImageSelectorWidget(
                      imageUrl: state.fetchProfileModel.image,
                      onImageSelected: (File image) {
                        setState(() {
                          selectedImage = image;
                        });
                      },
                      enabled: true,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'User info',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: darkMode ? TColors.white : TColors.black),
                    ),
                    const SizedBox(height: 10),
                    Form(
                      child: Column(
                        children: [
                          TextFormField(
                            //color of the text to be conditional based on dark mode
                            controller: _firstNameController,
                            style: TextStyle(color: darkMode ? TColors.white : TColors.black),

                            decoration: InputDecoration(
                              labelText: 'First Name',
                              labelStyle: TextStyle(color: darkMode ? TColors.white : TColors.black),
                            ),
                            maxLines: 1,
                          ),
                          const SizedBox(
                            height: TSizes.spaceBtwInputFields,
                          ),
                          TextFormField(
                            controller: _lastNameController,
                            style: TextStyle(color: darkMode ? TColors.white : TColors.black),
                            decoration: InputDecoration(
                              labelText: 'Last Name',
                              labelStyle: TextStyle(color: darkMode ? TColors.white : TColors.black),
                            ),
                            maxLines: 1,
                          ),
                          const SizedBox(
                            height: TSizes.spaceBtwInputFields,
                          ),
                          TextFormField(
                            controller: _emailController,
                            style: TextStyle(color: darkMode ? TColors.white : TColors.black),
                            decoration: InputDecoration(
                              //change the color of the text to be conditional based on dark mode
                              labelText: 'Email read-only',
                              labelStyle: TextStyle(color: darkMode ? TColors.white : TColors.black),
                            ),
                            maxLines: 1,
                            readOnly: true,
                          ),
                          const SizedBox(
                            height: TSizes.spaceBtwSections,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              color: Colors.transparent,
                              width: TDeviceUtils.getScreenWidth(context) * 0.8,
                              child: ElevatedButton(
                                onPressed: () async {
                                  print('First Name: ${_firstNameController.text}');
                                  print('Last Name: ${_lastNameController.text}');
                                  print('Imagepath: $selectedImage');

                                  // var userId = await TLocalStorage.getString('id');
                                  var userId = state.fetchProfileModel.id;
                                  // ignore: unnecessary_null_comparison
                                  if (userId != null) {
                                    BlocProvider.of<UserProfileBloc>(context).add(
                                      UpdateUserProfile(
                                        UpdateProfileModel(
                                          id: userId,
                                          email: _emailController.text,
                                          image: selectedImage,
                                          firstName: _firstNameController.text,
                                          lastName: _lastNameController.text,
                                        ),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: CustomSnackBarContent(
                                          snackBarTitle: 'Oops!',
                                          snackBarSubtitle: 'Error occurred when updating the profile. Please try again.',
                                          backgroundColor: TColors.error,
                                        ),
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: Colors.transparent,
                                        elevation: 0,
                                      ),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: TColors.primaryColor,
                                  side: const BorderSide(color: TColors.primaryColor),
                                ),
                                child: const Text(
                                  'Update',
                                  style: TextStyle(color: TColors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is UserProfileUpdated) {
            // Trigger a reload of the profile data
            BlocProvider.of<UserProfileBloc>(context).add(FetchUserProfile());
            return const SizedBox();
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
