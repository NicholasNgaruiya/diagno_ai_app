import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_frontend/data/shop/blocs/categories/bloc/categories_bloc.dart';
import 'package:restaurant_frontend/features/shop/admin/models/create_category_item.dart';

import '../../../../../common/widgets/dashboard/image_selector.dart';
import '../../../../../common/widgets/errors/custom_snackbar_content.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';

class AddCategoryPage extends StatefulWidget {
  const AddCategoryPage({super.key});

  @override
  State<AddCategoryPage> createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  final TextEditingController categoryNamecontroller = TextEditingController();
  final TextEditingController categoryDescriptionController = TextEditingController();

  File? selectedImage;

  @override
  void dispose() {
    categoryNamecontroller.dispose();
    categoryDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create Category'),
        ),
        body: BlocListener<CategoriesBloc, CategoriesState>(
          listener: (context, state) {
            if (state is CreateCategoryFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  // content: Text(state.error.toString()),
                  content: CustomSnackBarContent(
                    snackBarTitle: 'Oops!',
                    snackBarSubtitle: state.error.toString(),
                    // snackBarSubtitle: TTexts.emailAlreadyExistsError,
                    backgroundColor: TColors.error,
                  ),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
              );
            } else if (state is CreateCategorySuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: CustomSnackBarContent(
                    snackBarTitle: 'Wohoo!',
                    snackBarSubtitle: 'Category Created successfully',
                    backgroundColor: TColors.success,
                  ),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  // content: Text(TTexts.getAccountCreatedTitle),
                ),
              );
              BlocProvider.of<CategoriesBloc>(context).add(FetchCategoriesEvent());

              Navigator.of(context).pop();
            }
          },
          child: BlocBuilder<CategoriesBloc, CategoriesState>(
            builder: (context, state) {
              if (state is CategoryLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: TColors.primaryColor,
                  ),
                );
              } else {
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
                          onImageSelected: (File image) {
                            setState(() {
                              selectedImage = image; //?IF it doesn't work setstate
                            });
                          },
                          enabled: true,
                        ),
                        const SizedBox(height: TSizes.spaceBtwSections),
                        Text(
                          'Category info',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 10),
                        Form(
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextFormField(
                                controller: categoryNamecontroller,
                                decoration: const InputDecoration(
                                  labelText: 'Category Name',
                                ),
                              ),
                              const SizedBox(
                                height: TSizes.spaceBtwInputFields,
                              ),
                              TextFormField(
                                controller: categoryDescriptionController,
                                maxLines: 4,
                                decoration: const InputDecoration(
                                  labelText: 'Category Description',
                                ),
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  color: Colors.transparent,
                                  width: TDeviceUtils.getScreenWidth(context) * 0.8,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      _uploadCategory();
                                      print('Category Name: ${categoryNamecontroller.text}');
                                      print('Category Description: ${categoryDescriptionController.text}');
                                      print('Selected Image: $selectedImage');
                                      setState(() {
                                        // categoryNamecontroller.clear();
                                        // categoryDescriptionController.clear();
                                        // selectedImage = null;
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: TColors.success,
                                      side: const BorderSide(color: TColors.success),
                                    ),
                                    child: const Text('Create'),
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
              }
            },
          ),
        ),
      ),
    );
  }

  void _uploadCategory() {
    print('Button clicked');
    if (categoryNamecontroller.text.isNotEmpty && categoryDescriptionController.text.isNotEmpty && selectedImage != null) {
      try {
        BlocProvider.of<CategoriesBloc>(context).add(
          CreateCategoryButtonClickedEvent(
            createCategoryItem: CreateCategoryItem(
              name: categoryNamecontroller.text,
              description: categoryDescriptionController.text,
              image: selectedImage,
            ),
          ),
        );
      } catch (e) {
        print(e);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: CustomSnackBarContent(
            snackBarTitle: 'Oops!',
            snackBarSubtitle: 'Please fill all fields',
            backgroundColor: TColors.error,
          ),
          duration: Duration(milliseconds: 1500),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      );
    }
  }
}
