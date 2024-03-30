import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restaurant_frontend/features/shop/admin/screens/widgets/add_product_image.dart';
import 'package:restaurant_frontend/features/shop/admin/screens/widgets/select_category.dart';
import 'package:restaurant_frontend/utils/device/device_utility.dart';

import '../../../../utils/constants/sizes.dart';

class AddProductsPage extends StatefulWidget {
  const AddProductsPage({super.key});

  @override
  State<AddProductsPage> createState() => _AddProductsPageState();
}

class _AddProductsPageState extends State<AddProductsPage> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController productPriceController = TextEditingController();
  final TextEditingController productDescriptionController = TextEditingController();
  String? dropDownValue;
  var items = ['Drinks', 'Food', 'Snacks', 'Others'];

  File? selectedImage;
  String? selectedCategory;

  @override
  void dispose() {
    productNameController.dispose();
    productPriceController.dispose();
    productDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Product'),
          toolbarHeight: TDeviceUtils.getAppBarHeight(context),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Add Image',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 10),
                  AddProductImage(
                    onImageSelected: (File image) {
                      setState(() {
                        selectedImage = image; //store the selected image
                      });
                    },
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Text(
                    'Select Category',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 10),
                  const SelectCategorywidget(),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Text(
                    'Product info',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 10),
                  Form(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: productNameController,
                                expands: false,
                                decoration: const InputDecoration(
                                  labelText: 'Product Name',
                                ),
                              ),
                            ),
                            const SizedBox(width: TSizes.spaceBtwInputFields),
                            Expanded(
                              child: TextFormField(
                                controller: productPriceController,
                                expands: false,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  labelText: 'Price',
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: TSizes.spaceBtwInputFields),
                        const SizedBox(height: TSizes.spaceBtwInputFields),
                        TextFormField(
                          controller: productDescriptionController,
                          maxLines: null,
                          decoration: const InputDecoration(
                            labelText: 'Product Description',
                          ),
                        ),
                        const SizedBox(height: TSizes.spaceBtwItems),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: () {
                                  // setState(() {
                                  //   selectedCategory = null; // Clear selected category
                                  //   selectedImage = null; // Clear selected image

                                  //   // Call clear methods of child widgets
                                  //   // Clear category field

                                  //   productNameController.clear(); // Clear product name
                                  //   productPriceController.clear(); // Clear product price
                                  //   productDescriptionController.clear(); // Clear product description
                                  // });
                                },
                                child: Container(
                                  height: 50,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Clear',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  // if (selectedImage != null &&
                                  //     productNameController.text.isNotEmpty &&
                                  //     productPriceController.text.isNotEmpty &&
                                  //     productDescriptionController.text.isNotEmpty &&
                                  //     selectedCategory != null) {
                                  //   print('Selected Image: $selectedImage');
                                  //   print('Product Name: ${productNameController.text}');
                                  //   print('Product Price: ${productPriceController.text}');
                                  //   print('Product Description: ${productDescriptionController.text}');
                                  // } else {
                                  //   print('No Image Selected');
                                  // }
                                },
                                child: Container(
                                  height: 50,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Upload',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
