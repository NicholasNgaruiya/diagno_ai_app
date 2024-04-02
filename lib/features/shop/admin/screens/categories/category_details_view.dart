import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_frontend/data/shop/blocs/categories/bloc/categories_bloc.dart';
import 'package:restaurant_frontend/features/shop/admin/models/update_category_item.dart';

import '../../../../../common/widgets/dashboard/image_selector.dart';
import '../../../../../data/shop/blocs/categories/category_details/bloc/category_details_bloc.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../models/category_item.dart';

class CategoryDetailsView extends StatelessWidget {
  final CategoryItem categoryItem;
  const CategoryDetailsView({super.key, required this.categoryItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category Details'),
      ),
      body: BlocConsumer<CategoryDetailsBloc, CategoryDetailsState>(
        listener: (context, state) {
          if (state is SaveSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: TColors.success,
              ),
            );
            BlocProvider.of<CategoriesBloc>(context).add(FetchCategoriesEvent());
            // Navigator.pushNamed(context, '/categoriesScreen');
            // Navigator.popUntil(context, ModalRoute.withName('/categoriesScreen'));
            Navigator.of(context).pop();
          } else if (state is SaveFailedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: TColors.error,
              ),
            );

            Navigator.of(context).pop();
          } else if (state is ModelSwitchedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('switched to editing mode'),
                backgroundColor: TColors.success,
              ),
            );
          } else if (state is DeletedCategorySuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: TColors.success,
              ),
            );
            BlocProvider.of<CategoriesBloc>(context).add(FetchCategoriesEvent());

            Navigator.of(context).pop();
          } else if (state is DeletedCategoryFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: TColors.error,
              ),
            );
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          if (state is CategoryDetailsInitial) {
            return _buildCategoryDetailsInitial(context, state);
          } else if (state is CategoryDetailsEditing) {
            return _buildCategoryDetailsEditing(context, state);
          } else if (state is CategoryDetailsLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: TColors.primaryColor,
              ),
            );
          } else {
            //Handle Other state's if needed
            return Container();
          }
        },
      ),
    );
  }

  Widget _buildCategoryDetailsInitial(BuildContext context, CategoryDetailsInitial state) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              height: TDeviceUtils.getScreenHeight(context) * 0.7,
              width: TDeviceUtils.getScreenWidth(context),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: TSizes.spaceBtwItems),
                    // Text(
                    //   'Category ID : ${state.categoryItem.id}',
                    // ),
                    Text(
                      'Category Name :',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),

                    TextFormField(
                      initialValue: state.categoryItem.name,
                      readOnly: true,
                    ),

                    const SizedBox(height: TSizes.spaceBtwItems),
                    Text(
                      'Category Description :',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),

                    TextFormField(
                      initialValue: state.categoryItem.description,
                      readOnly: true,
                      maxLines: 3,
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    Text(
                      'Category Image :',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    // Container that displays the image
                    ImageSelectorWidget(
                      imageUrl: state.categoryItem.image,
                      enabled: false,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: TDeviceUtils.getScreenWidth(context) * 0.4,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle edit button clicked
                      BlocProvider.of<CategoryDetailsBloc>(context).add(EditButtonClickedEvent());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: TColors.success,
                      side: const BorderSide(color: TColors.success),
                    ),
                    child: const Text('Edit'),
                  ),
                ),
                SizedBox(
                  width: TDeviceUtils.getScreenWidth(context) * 0.4,
                  child: ElevatedButton(
                    onPressed: () {
                      print('Category id is ${state.categoryItem.id}');
                      // Handle delete button clicked
                      BlocProvider.of<CategoryDetailsBloc>(context).add(DeleteButtonClickedEvent(state.categoryItem.id));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: TColors.error,
                      side: const BorderSide(color: TColors.error),
                    ),
                    child: const Text('Delete'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildCategoryDetailsEditing(BuildContext context, CategoryDetailsEditing state) {
  final categoryItem = state.categoryItem;
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late FocusNode nameFocusNode;
  File? selectedImage;

  nameController = TextEditingController(text: categoryItem.name);
  descriptionController = TextEditingController(text: categoryItem.description);
  nameFocusNode = FocusNode();

  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            height: TDeviceUtils.getScreenHeight(context) * 0.7,
            width: TDeviceUtils.getScreenWidth(context),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: TSizes.spaceBtwItems),
                  // Text(
                  //   'Category ID : ${categoryItem.id}',
                  // ),
                  Text(
                    'Category Name :',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  TextFormField(
                    controller: nameController,
                    readOnly: false,
                    focusNode: nameFocusNode,
                    onChanged: (value) {
                      // Handle changes in the name field
                    },
                  ),
                  const SizedBox(height: TSizes.spaceBtwInputFields),
                  Text(
                    'Category Description :',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  TextFormField(
                    controller: descriptionController,
                    readOnly: false,
                    maxLines: 3,
                    onChanged: (value) {
                      // Handle changes in the description field
                    },
                  ),
                  const SizedBox(height: TSizes.spaceBtwInputFields),
                  Text(
                    'Category Image :',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  // Container that displays the image
                  ImageSelectorWidget(
                    onImageSelected: (File image) {
                      // Handle image selection
                      selectedImage = image;
                    },
                    imageUrl: categoryItem.image,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwSections),
          SizedBox(
            width: TDeviceUtils.getScreenWidth(context) * 0.4,
            child: ElevatedButton(
              onPressed: () {
                print(nameController.text);
                print(descriptionController.text);
                print(selectedImage);
                // Handle save button clicked
                BlocProvider.of<CategoryDetailsBloc>(context).add(
                  SaveButtonClickedEvent(
                    updateCategoryItem: UpdateCategoryItem(
                      name: nameController.text,
                      description: descriptionController.text,
                      image: selectedImage,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: TColors.success,
                side: const BorderSide(color: TColors.success),
              ),
              child: const Text('Save'),
            ),
          ),
        ],
      ),
    ),
  );
}