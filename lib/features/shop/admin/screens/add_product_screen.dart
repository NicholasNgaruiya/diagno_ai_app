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
  String? dropDownValue;
  var items = ['Drinks', 'Food', 'Snacks', 'Others'];
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
                  const AddProductImage(),
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
                                expands: false,
                                decoration: const InputDecoration(
                                  labelText: 'Product Name',
                                ),
                              ),
                            ),
                            const SizedBox(width: TSizes.spaceBtwInputFields),
                            Expanded(
                              child: TextFormField(
                                expands: false,
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
                                onTap: () {},
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
                                onTap: () {},
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
