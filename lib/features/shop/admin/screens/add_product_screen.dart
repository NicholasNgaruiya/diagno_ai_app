import 'package:flutter/material.dart';
import 'package:restaurant_frontend/features/shop/admin/screens/widgets/add_product_image.dart';
import 'package:restaurant_frontend/features/shop/admin/screens/widgets/select_category.dart';
import 'package:restaurant_frontend/utils/device/device_utility.dart';

import '../../../../utils/constants/sizes.dart';

class AddProductsPage extends StatelessWidget {
  const AddProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Product'),
          toolbarHeight: TDeviceUtils.getAppBarHeight(context),
        ),
        body: Container(
          padding: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AddProductImage(),
                const SizedBox(height: TSizes.spaceBtwSections),
                Text(
                  'Select Category',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(
                  height: 10,
                ),
                const SelectCategorywidget(),
                const SizedBox(height: TSizes.spaceBtwSections),
                const Text(' Add Products'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
