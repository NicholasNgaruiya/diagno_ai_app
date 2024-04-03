import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_frontend/features/shop/customer/screens/widgets/get_username_widget.dart';
import 'package:restaurant_frontend/utils/constants/colors.dart';
import 'package:restaurant_frontend/utils/device/device_utility.dart';
import 'package:restaurant_frontend/utils/helpers/helper_functions.dart';
import 'package:restaurant_frontend/utils/local_storage/storage_utility.dart';

import '../../../../../data/shop/blocs/categories/bloc/categories_bloc.dart';
import '../../../../../utils/constants/sizes.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final List imgData = [
    'assets/images/dashboard_images/addproducts.png',
    'assets/images/dashboard_images/addproducts.png',
    'assets/images/dashboard_images/vieworders.png',
    'assets/images/dashboard_images/vieworders.png',
    'assets/images/dashboard_images/vieworders.png',
  ];

  final List titles = [
    'Products',
    'Edit Products',
    'Categories',
    'View Orders',
    'View Orders',
  ];
  String? userName;

  Future<void> _loadSavedCredentials() async {
    final storedUserName = await TLocalStorage.getString('user_name');
    setState(() {
      userName = storedUserName;
    });
  }

  @override
  void initState() {
    _loadSavedCredentials();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // height = TDeviceUtils.getScreenHeight(context);
    // width = TDeviceUtils.getScreenWidth(context);
    final dark = THelperFunctions.isDarkMode(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            color: TColors.primaryColor,
            height: TDeviceUtils.getScreenHeight(context),
            width: TDeviceUtils.getScreenWidth(context),
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      // color: TColors.black,
                      ),
                  height: TDeviceUtils.getScreenHeight(context) * 0.15,
                  width: TDeviceUtils.getScreenWidth(context),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 15,
                          left: 20,
                        ),
                        child: Text(
                          'Dashboard',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                      const GetUsernameWidget(),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: dark ? TColors.grey : TColors.grey,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  height: TDeviceUtils.getScreenHeight(context) * 0.85,
                  width: TDeviceUtils.getScreenWidth(context),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.0,
                      mainAxisSpacing: 15,
                    ),
                    shrinkWrap: true,
                    // physics: const NeverScrollableScrollPhysics(),
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: imgData.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          switch (index) {
                            case 0:
                              Navigator.pushNamed(context, '/addProducts');
                              break;
                            case 1:
                              Navigator.pushNamed(context, '/editProducts');
                              break;
                            case 2:
                              BlocProvider.of<CategoriesBloc>(context).add(FetchCategoriesEvent());

                              Navigator.pushNamed(context, '/categoriesScreen');
                              break;
                            case 3:
                              Navigator.pushNamed(context, '/categoriesScreen');
                              break;
                            default:
                              break;
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: TColors.white,
                            // boxShadow: const [
                            //   BoxShadow(
                            //     color: Colors.black,
                            //     spreadRadius: 0.5,
                            //     blurRadius: 3,
                            //   ),
                            // ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                imgData[index],
                                width: 100,
                              ),
                              Text(
                                titles[index],
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
