import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:restaurant_frontend/features/shop/customer/screens/widgets/item_widget.dart';
import 'package:restaurant_frontend/utils/device/device_utility.dart';

import '../../../../data/shop/blocs/categories/bloc/categories_bloc.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import 'widgets/categories_list.dart';
import 'widgets/custom_searchbar.dart';
import 'widgets/get_username_widget.dart';
import 'widgets/section_heading.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  late CategoriesBloc _categoriesBloc;
  @override
  void initState() {
    super.initState();
    _categoriesBloc = BlocProvider.of<CategoriesBloc>(context);
    _categoriesBloc.add(FetchCategoriesEvent()); // Dispatch FetchCategoriesEvent
  } // Declare CategoriesBloc

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            color: TColors.primaryColor,
            height: TDeviceUtils.getScreenHeight(context),
            width: TDeviceUtils.getScreenWidth(context),
            child: Column(
              children: [
                SizedBox(
                  height: TDeviceUtils.getScreenHeight(context) * 0.20,
                  width: TDeviceUtils.getScreenWidth(context),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const GetUsernameWidget(),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 15,
                          ),
                          child: Text(
                            'Welcome to FlavorQuest!',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                        const SizedBox(
                          height: TSizes.spaceBtwItems,
                        ),
                        const Center(
                          child: TSearchBar(
                            icon: Iconsax.search_normal,
                            backgroundColor: Colors.white,
                            borderColor: Colors.white,
                            text: 'Search',
                            textColor: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //?Beginning of the rounded container
                Container(
                  decoration: const BoxDecoration(
                    color: TColors.white,
                    // color: dark ? TColors.grey : TColors.grey,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  height: TDeviceUtils.getScreenHeight(context) * 80,
                  width: TDeviceUtils.getScreenWidth(context),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Column(
                      children: [
                        ///---Categories Heading
                        TSectionHeading(
                          headingTitle: 'Categories',
                          buttonTitle: 'View All',
                          textColor: TColors.black,
                          onPressed: () {},
                          showActionButton: true,
                        ),

                        ///Categories
                        const CategoriesListView(),

                        ///Products
                        TSectionHeading(
                          headingTitle: 'Recommendations',
                          buttonTitle: 'View All',
                          textColor: TColors.black,
                          onPressed: () {},
                          showActionButton: true,
                        ),
                        const ItemsWidget(),

                        const Text(
                          'Recommendations',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  //Text
                  //SearchBar
                  //Categories List
                ), //Products List
              ],
            ),
          ),
        ),
      ),
    );
  }
}
