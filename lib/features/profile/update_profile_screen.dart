import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_frontend/common/widgets/dashboard/image_selector.dart';
import 'package:restaurant_frontend/utils/constants/sizes.dart';

import '../../common/widgets/errors/custom_snackbar_content.dart';
import '../../data/authentication/blocs/profile/bloc/user_profile_bloc.dart';
import '../../utils/constants/colors.dart';
import '../../utils/device/device_utility.dart';
import '../../utils/local_storage/storage_utility.dart';
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
    return Scaffold(
      backgroundColor: TColors.white,
      appBar: AppBar(
        title: const Text('Update Profile'),
        backgroundColor: TColors.white,
      ),
      body: BlocConsumer<UserProfileBloc, UserProfileState>(
        listener: (context, state) {
          if (state is UserProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                // content: Text(state.error.toString()),
                content: CustomSnackBarContent(
                  snackBarTitle: 'Oops!',
                  // snackBarSubtitle: state.error.toString(),
                  snackBarSubtitle: state.message,
                  // snackBarSubtitle: TTexts.emailAlreadyExistsError,
                  backgroundColor: TColors.error,
                ),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
            );
            Navigator.of(context).pop();
          } else if (state is UserProfileUpdated) {
            //TODO: Use these stored variables to update the app
            //Combine the first name and last name to form the full name
            TLocalStorage.saveString('user_name', '${state.updateProfileModel.firstName} ${state.updateProfileModel.lastName}');
            // TLocalStorage.saveString('firstName', state.updateProfileModel.firstName);
            // TLocalStorage.saveString('lastName', state.updateProfileModel.lastName);
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
          } else if (state is UserProfileLoaded) {
            print(state.fetchProfileModel.firstName);
            print(state.fetchProfileModel.lastName);
            _firstNameController.text = state.fetchProfileModel.firstName;
            _lastNameController.text = state.fetchProfileModel.lastName;
            _emailController.text = state.fetchProfileModel.email;
            final fetchedImageUrl = state.fetchProfileModel.image;
            int httpIndex = fetchedImageUrl!.indexOf('http');
            final imageUrl = fetchedImageUrl.substring(httpIndex);
            print('Image URL: $imageUrl');
            setState(() {
              this.imageUrl = imageUrl; // Update the imageUrl
            });
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
            // _firstNameController.text = state.fetchProfileModel.firstName;
            // _lastNameController.text = state.fetchProfileModel.lastName;
            // _emailController.text = state.fetchProfileModel.email;
            // final fetchedImageUrl = state.fetchProfileModel.image;
            // //Find the index of http
            // int httpIndex = fetchedImageUrl!.indexOf('http');
            // //Extract the subsstring starting from 'http'
            // final imageUrl = fetchedImageUrl.substring(httpIndex);
            // print('Image URL: $imageUrl');

            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add Image',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 10),
                    ImageSelectorWidget(
                      imageUrl: imageUrl,
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
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 10),
                    Form(
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _firstNameController,
                            decoration: const InputDecoration(
                              labelText: 'First Name',
                            ),
                            maxLines: 1,
                          ),
                          const SizedBox(
                            height: TSizes.spaceBtwInputFields,
                          ),
                          TextFormField(
                            controller: _lastNameController,
                            decoration: const InputDecoration(
                              labelText: 'Last Name',
                            ),
                            maxLines: 1,
                          ),
                          const SizedBox(
                            height: TSizes.spaceBtwInputFields,
                          ),
                          TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              labelText: 'Email',
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
                                  //print the firstname,lastname and image url
                                  print('First Name: ${_firstNameController.text}');
                                  print('Last Name: ${_lastNameController.text}');
                                  print('Imagepath: $selectedImage');

                                  var userId = await TLocalStorage.getString('id');
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
                                          snackBarSubtitle: 'User ID not found',
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
                                  backgroundColor: TColors.success,
                                  side: const BorderSide(color: TColors.success),
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
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
