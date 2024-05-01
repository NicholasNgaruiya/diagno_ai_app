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
import '../../../profile/widgets/get_username_widget.dart';
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColors.primaryColor,
        elevation: 0,
        title: const GetUsernameWidget(),
        actions: [
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Iconsax.shopping_cart,
                  color: TColors.white,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/profileScreen');
                },
                icon: const Icon(
                  Iconsax.user,
                  color: TColors.white,
                ),
              ),
            ],
          ),
        ],
        toolbarHeight: TDeviceUtils.getScreenHeight(context) * 0.080,
      ),
      // backgroundColor: TColors.primaryColor,
      body: Column(
        children: [
          /// ---Categories Section
          Expanded(
            child: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom,
                ),
                child: Container(
                  // height: TDeviceUtils.getScreenHeight(context) * 0.8,
                  height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.bottom - kBottomNavigationBarHeight,
                  decoration: const BoxDecoration(
                    color: TColors.white,
                    // borderRadius: BorderRadius.only(
                    //   topLeft: Radius.circular(30),
                    //   topRight: Radius.circular(30),
                    // ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    child: CategoriesGridView(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
