import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/shop/blocs/categories/category_details/bloc/category_details_bloc.dart';
import '../../models/category_item.dart';
import 'category_details_view.dart';

class CategoryDetailsScreen extends StatelessWidget {
  final CategoryItem categories;
  const CategoryDetailsScreen({
    super.key,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryDetailsBloc(categories),
      child: CategoryDetailsView(categoryItem: categories),
    );
  }
}

// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:diagno_ai/common/widgets/dashboard/image_selector.dart';

// import 'package:diagno_ai/utils/constants/colors.dart';
// import 'package:diagno_ai/utils/device/device_utility.dart';

// import '../../../../../data/shop/blocs/categories/category_details/bloc/category_details_bloc.dart';
// import '../../../../../utils/constants/sizes.dart';
// import '../../models/category_item.dart';

// class CategoryDetailsScreen extends StatefulWidget {
//   final CategoryItem categories;

//   const CategoryDetailsScreen({
//     super.key,
//     required this.categories,
//   });

//   @override
//   State<CategoryDetailsScreen> createState() => _CategoryDetailsScreenState();
// }

// class _CategoryDetailsScreenState extends State<CategoryDetailsScreen> {
//   late TextEditingController _nameController;
//   late TextEditingController _descriptionController;
//   late FocusNode _nameFocusNode;
//   bool isEditable = false;

//   String newName = '';
//   String newDescription = '';
//   File? selectedImage;

//   @override
//   void initState() {
//     super.initState();
//     _nameController = TextEditingController(text: widget.categories.name);
//     _descriptionController = TextEditingController(text: widget.categories.description);
//     _nameFocusNode = FocusNode();
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _descriptionController.dispose();
//     _nameFocusNode.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Category Details'),
//         ),
//         body: BlocConsumer<CategoryDetailsBloc, CategoryDetailsState>(
//           listener: (context, state) {
//             if (state is SaveSuccessState) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text(state.message),
//                   backgroundColor: TColors.success,
//                 ),
//               );
//             } else if (state is SaveFailedState) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text(state.message),
//                   backgroundColor: TColors.error,
//                 ),
//               );
//             } else if (state is ModelSwitchedState) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(
//                   content: Text('Model switched'),
//                   backgroundColor: TColors.success,
//                 ),
//               );
//             }
//           },
//           builder: (context, state) {
//             if (state is CategoryDetailsInitial) {
//               return _buildCategoryDetailsInitial(context, state);
//             }
//             // else if (state is CategoryDetailsEditing) {
//             //   return _buildCategoryDetailsEditing(context, state);
//             // }
//             else if (state is CategoryDetailsLoadingState) {
//               return const Center(
//                 child: CircularProgressIndicator(
//                   color: TColors.primaryColor,
//                 ),
//               );
//             } else {
//               //Handle Other state's if needed
//               return Container();
//             }
//           },
//         ),
//       ),
//     );
//   }

//   // Widget _buildCategoryDetailsInitial(BuildContext context, CategoryDetailsInitial state) {
//   //   return SingleChildScrollView(
//   //     child: Padding(
//   //       padding: const EdgeInsets.all(16),
//   //       child: Column(
//   //         children: [
//   //           Container(
//   //             height: TDeviceUtils.getScreenHeight(context) * 0.7,
//   //             width: TDeviceUtils.getScreenWidth(context),
//   //             decoration: BoxDecoration(
//   //               borderRadius: BorderRadius.circular(10),
//   //               border: Border.all(
//   //                 color: Colors.grey,
//   //               ),
//   //             ),
//   //             child: Padding(
//   //               padding: const EdgeInsets.all(8.0),
//   //               child: Column(
//   //                 crossAxisAlignment: CrossAxisAlignment.start,
//   //                 children: [
//   //                   const SizedBox(height: TSizes.spaceBtwItems),
//   //                   Text(
//   //                     'Category ID : ${state.categoryItem.id}',
//   //                   ),
//   //                   Text(
//   //                     'Category Name : ${state.categoryItem.name}',
//   //                     style: Theme.of(context).textTheme.titleMedium,
//   //                   ),
//   //                   const SizedBox(height: TSizes.spaceBtwItems),
//   //                   Text(
//   //                     'Category Description : ${state.categoryItem.description}',
//   //                     style: Theme.of(context).textTheme.titleMedium,
//   //                   ),
//   //                   const SizedBox(height: TSizes.spaceBtwItems),
//   //                   Text(
//   //                     'Category Image :',
//   //                     style: Theme.of(context).textTheme.titleMedium,
//   //                   ),
//   //                   const SizedBox(height: TSizes.spaceBtwItems),
//   //                   // Container that displays the image
//   //                   ImageSelectorWidget(
//   //                     imageUrl: state.categoryItem.image,
//   //                   ),
//   //                 ],
//   //               ),
//   //             ),
//   //           ),
//   //           const SizedBox(height: TSizes.spaceBtwSections),
//   //           ElevatedButton(
//   //             onPressed: () {
//   //               BlocProvider.of<CategoryDetailsBloc>(context).add(EditButtonClickedEvent());
//   //             },
//   //             style: ElevatedButton.styleFrom(
//   //               backgroundColor: TColors.success,
//   //               side: const BorderSide(color: TColors.success),
//   //             ),
//   //             child: const Text('Edit'),
//   //           ),
//   //         ],
//   //       ),
//   //     ),
//   //   );
//   // }

//   // Widget _buildCategoryDetailsInitial(BuildContext context, CategoryDetailsInitial state) {
//   //   return SingleChildScrollView(
//   //     child: Padding(
//   //       padding: const EdgeInsets.all(16),
//   //       child: Column(
//   //         children: [
//   //           Container(
//   //             height: TDeviceUtils.getScreenHeight(context) * 0.7,
//   //             width: TDeviceUtils.getScreenWidth(context),
//   //             decoration: BoxDecoration(
//   //               borderRadius: BorderRadius.circular(10),
//   //               border: Border.all(
//   //                 color: Colors.grey,
//   //               ),
//   //             ),
//   //             child: Padding(
//   //               padding: const EdgeInsets.all(8.0),
//   //               child: Column(
//   //                 crossAxisAlignment: CrossAxisAlignment.start,
//   //                 children: [
//   //                   const SizedBox(height: TSizes.spaceBtwItems),
//   //                   Text(
//   //                     'Category ID : ${widget.categories.id}',
//   //                   ),
//   //                   Text(
//   //                     'Category Name :',
//   //                     style: Theme.of(context).textTheme.titleMedium,
//   //                   ),
//   //                   const SizedBox(height: TSizes.spaceBtwItems),
//   //                   TextFormField(
//   //                     controller: _nameController,
//   //                     readOnly: !isEditable,
//   //                     focusNode: _nameFocusNode,
//   //                     onChanged: (value) {
//   //                       newName = value;
//   //                       // Handle changes in the name field
//   //                       print('New category name: $value');
//   //                     },
//   //                   ),
//   //                   const SizedBox(height: TSizes.spaceBtwInputFields),
//   //                   Text(
//   //                     'Category Description :',
//   //                     style: Theme.of(context).textTheme.titleMedium,
//   //                   ),
//   //                   const SizedBox(height: TSizes.spaceBtwItems),

//   //                   TextFormField(
//   //                     controller: _descriptionController,
//   //                     readOnly: !isEditable,
//   //                     maxLines: 3,
//   //                     onChanged: (value) {
//   //                       newDescription = value;
//   //                       // Handle changes in the name field
//   //                       print('New category name: $value');
//   //                     },
//   //                   ),
//   //                   const SizedBox(height: TSizes.spaceBtwInputFields),
//   //                   Text(
//   //                     'Category Image :',
//   //                     style: Theme.of(context).textTheme.titleMedium,
//   //                   ),
//   //                   const SizedBox(height: TSizes.spaceBtwItems),
//   //                   //Container that displays the image
//   //                   isEditable
//   //                       ? ImageSelectorWidget(
//   //                           //Handle on image selected like in the add product page
//   //                           onImageSelected: (File image) {
//   //                             setState(() {
//   //                               selectedImage = image; //store the selected image
//   //                             });
//   //                           },
//   //                           imageUrl: widget.categories.image,
//   //                         )
//   //                       : Container(
//   //                           height: 150,
//   //                           width: 200,
//   //                           decoration: BoxDecoration(
//   //                             border: Border.all(
//   //                               color: Colors.grey,
//   //                             ),
//   //                             borderRadius: BorderRadius.circular(10),
//   //                             image: DecorationImage(
//   //                               image: NetworkImage(widget.categories.image ?? 'assets/images/dashboard_images/add-item.png'),
//   //                               fit: BoxFit.cover,
//   //                             ),
//   //                           ),
//   //                         ),
//   //                 ],
//   //               ),
//   //             ),
//   //           ),
//   //           const SizedBox(
//   //             height: TSizes.spaceBtwSections,
//   //           ),
//   //           Row(
//   //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   //             children: [
//   //               SizedBox(
//   //                 width: TDeviceUtils.getScreenWidth(context) * 0.4,
//   //                 child: ElevatedButton(
//   //                   onPressed: () {
//   //                     setState(() {
//   //                       isEditable = !isEditable;
//   //                       if (isEditable) {
//   //                         // Set focus to the name field when entering edit mode
//   //                         FocusScope.of(context).requestFocus(_nameFocusNode);
//   //                       }
//   //                     });

//   //                     print(newName);
//   //                     print(newDescription);
//   //                   },
//   //                   style: ElevatedButton.styleFrom(
//   //                     backgroundColor: TColors.success,
//   //                     side: const BorderSide(color: TColors.success),
//   //                   ),
//   //                   child: Text(isEditable ? 'Save' : 'Edit'),
//   //                 ),
//   //               ),
//   //               SizedBox(
//   //                 width: TDeviceUtils.getScreenWidth(context) * 0.4,
//   //                 child: ElevatedButton(
//   //                   onPressed: () {
//   //                     //Print saved image
//   //                     print('Selected image is $selectedImage');
//   //                   },
//   //                   // style: ElevatedButton.styleFrom(
//   //                   //   foregroundColor: TColors.error,
//   //                   // ),
//   //                   style: ElevatedButton.styleFrom(
//   //                     backgroundColor: TColors.error,
//   //                     side: const BorderSide(color: TColors.error),
//   //                   ),
//   //                   child: const Text(
//   //                     'Delete',
//   //                   ),
//   //                 ),
//   //               ),
//   //             ],
//   //           ),
//   //         ],
//   //       ),
//   //     ),
//   //   );
//   // }

//   // Widget _buildCategoryDetailsEditing(BuildContext context, CategoryDetailsEditing state) {
//   //   final categoryItem = state.categoryItem;
//   //   late TextEditingController _nameController;
//   //   late TextEditingController _descriptionController;
//   //   late FocusNode _nameFocusNode;

//   //   _nameController = TextEditingController(text: categoryItem.name);
//   //   _descriptionController = TextEditingController(text: categoryItem.description);
//   //   _nameFocusNode = FocusNode();
//   // }
// }
