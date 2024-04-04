import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_frontend/data/shop/blocs/categories/bloc/categories_bloc.dart';
import 'package:restaurant_frontend/utils/device/device_utility.dart';
// import 'package:restaurant_frontend/utils/local_storage/storage_utility.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class CategoriesGridView extends StatelessWidget {
  const CategoriesGridView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (context, state) {
        if (state is CategoryLoading) {
          return const Center(
            child: CircularProgressIndicator(color: TColors.primaryColor),
          );
        } else if (state is FetchCategoriesSuccess) {
          final categories = state.categories;
          return GridView.builder(
            itemCount: categories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 10,
              childAspectRatio: 1.3, // Width/Height ratio
            ),
            // physics: const AlwaysScrollableScrollPhysics(),
            // shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(), // Disable GridView's built-in scrolling
            itemBuilder: (context, index) {
              final category = categories[index];
              return InkWell(
                onTap: () {
                  BlocProvider.of<CategoriesBloc>(context).add(
                    FetchProductsForCategoryEvent(categoryId: category.id),
                  );
                  print('Products for this category:${category.id}');
                  print('Clicked This category:${category.name}');
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        category.image ?? 'https://via.placeholder.com/150',
                        fit: BoxFit.cover,
                        height: 100,
                        width: TDeviceUtils.getScreenWidth(context) * 0.45,
                      ),
                    ),

                    // ),
                    const SizedBox(height: TSizes.spaceBtwItems / 2),
                    SizedBox(
                      width: double.infinity,
                      // color: Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 8,
                        ),
                        child: Text(
                          category.name.capitalize(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                          ),
                          textAlign: TextAlign.left,
                          //Capitalize the first letter of each word
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        } else if (state is FetchProductsForCategorySuccess) {
          return Text(
            'Products for this category:${state.fetchedCategoryItem.products.length}',
            style: const TextStyle(color: Colors.black),
          );
        } else if (state is FetchProductsForCategoryFailure) {
          return Center(
            child: Text('Error: ${state.error}'),
          );
        } else if (state is FetchCategoriesFailure) {
          return Center(
            child: Text('Error: ${state.error}'),
          );
        } else {
          return const Center(
            child: Text(
              'WTF',
              style: TextStyle(color: Colors.black),
            ),
          );
        }
      },
    );
  }

// extension StringExtensions on String {
//   String capitalize() {
//     return "${this[0].toUpperCase()}${this.substring(1)}";
//   }
// }
}

extension StringExtensions on String {
  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
