import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:restaurant_frontend/data/shop/blocs/categories/bloc/categories_bloc.dart';
import 'package:restaurant_frontend/features/shop/customer/models/new_product_item.dart';

import '../../../../utils/constants/colors.dart';

class CategoryProductsScreen extends StatefulWidget {
  const CategoryProductsScreen({
    super.key,
    required this.categoryImageUrl,
    required this.products,
    required this.categoryTitle,
    required this.categoryDescription,
  });
  final String categoryImageUrl;
  final String categoryTitle;
  final String categoryDescription;
  final List<Product> products;

  @override
  State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              // background: Image.asset(
              //   'assets/images/products_images/Untitled.jpeg',
              //   fit: BoxFit.cover,
              // ),
              background: Image.network(
                widget.categoryImageUrl,
                fit: BoxFit.cover,
              ),
            ),
            leading: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    BlocProvider.of<CategoriesBloc>(context).add(FetchCategoriesEvent());
                  },
                  icon: const Icon(
                    Iconsax.arrow_left,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
              ),
            ),
          ),

          /// CategoryInformation
          SliverToBoxAdapter(
            child: Column(
              children: [
                Text(
                  widget.categoryTitle,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.categoryDescription,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          //List of products
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return const Text('data');
              },
              childCount: widget.products.length,
            ),
          ),
        ],
      ),
    );
  }
}
