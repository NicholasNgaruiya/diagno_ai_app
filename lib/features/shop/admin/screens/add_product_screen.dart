import 'package:flutter/material.dart';
import 'package:restaurant_frontend/features/shop/admin/screens/widgets/add_product_image.dart';
import 'package:restaurant_frontend/utils/device/device_utility.dart';

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
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AddProductImage(),
              Text(' Add Products'),
            ],
          ),
        ),
      ),
    );
  }
}
