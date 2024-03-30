import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_frontend/data/shop/blocs/product/bloc/product_bloc.dart';
import 'package:restaurant_frontend/features/shop/admin/models/product_item.dart';
import 'package:restaurant_frontend/features/shop/admin/screens/widgets/add_product_image.dart';
import 'package:restaurant_frontend/features/shop/admin/screens/widgets/select_category.dart';
import 'package:restaurant_frontend/utils/constants/colors.dart';
import 'package:restaurant_frontend/utils/device/device_utility.dart';

import '../../../../common/widgets/errors/custom_snackbar_content.dart';
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

  File? selectedImage;
  String? selectedCategoryId;

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
        body: BlocListener<ProductBloc, ProductState>(
          listener: (context, state) {
            if (state is AddProductFailure) {
              //Handle failure state by showing a snack bar with the error message
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
            } else if (state is AddProductSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: CustomSnackBarContent(
                    snackBarTitle: 'Wohoo!',
                    snackBarSubtitle: 'Product Created successfully',
                    backgroundColor: TColors.success,
                  ),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  // content: Text(TTexts.getAccountCreatedTitle),
                ),
              );
            }
          },
          child: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is AddProductLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: TColors.primaryColor,
                  ),
                );
              } else {
                return SingleChildScrollView(
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
                          SelectCategorywidget(
                            onCategorySelected: (String selectedCategoryId) {
                              setState(() {
                                this.selectedCategoryId = selectedCategoryId;
                              });
                            },
                          ),
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
                                      SizedBox(
                                        width: 130,
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: TColors.error,
                                            side: const BorderSide(color: TColors.error),
                                          ),
                                          child: const Text('Clear'),
                                        ),
                                      ),
                                      Container(
                                        color: Colors.transparent,
                                        width: 130,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            _uploadProduct();
                                            print('Product Name: ${productNameController.text}');
                                            print('Product Price: ${productPriceController.text}');
                                            print('Product Description: ${productDescriptionController.text}');
                                            print('Selected Category: $selectedCategoryId');
                                            print('Selected Image: $selectedImage');
                                            setState(() {
                                              productNameController.clear();
                                              productPriceController.clear();
                                              productDescriptionController.clear();
                                              selectedCategoryId = null;
                                              selectedImage = null;
                                            });
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: TColors.success,
                                            side: const BorderSide(color: TColors.success),
                                          ),
                                          child: const Text('Upload Product'),
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
                );
              }
            },
          ),
        ),
      ),
    );
  }

  void _uploadProduct() {
    print('Button Clicked');
    if (productNameController.text.isNotEmpty &&
        productPriceController.text.isNotEmpty &&
        productDescriptionController.text.isNotEmpty &&
        selectedCategoryId != null &&
        selectedImage != null) {
      try {
        //Read the file as bytes
        // List<int> immageBytes = selectedImage!.readAsBytesSync();

        //Convert the bytes to base64
        // String base64Image = base64Encode(immageBytes);
        //dispatch aaddproductbuttonclickedevent
        BlocProvider.of<ProductBloc>(context).add(
          CreateProductButtonClickedEvent(
            productItem: ProductItem(
              productName: productNameController.text,
              category: selectedCategoryId ?? '',
              price: double.parse(productPriceController.text),
              description: productDescriptionController.text, image: selectedImage!,
              // imageBase64: base64Image,
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
