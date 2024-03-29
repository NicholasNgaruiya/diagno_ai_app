import 'package:flutter/material.dart';
import 'package:restaurant_frontend/utils/constants/colors.dart';
import 'package:restaurant_frontend/utils/device/device_utility.dart';
import 'package:restaurant_frontend/utils/helpers/helper_functions.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});

  final List imgData = [
    'assets/images/dashboard_images/addproducts.png',
    'assets/images/dashboard_images/addproducts.png',
    'assets/images/dashboard_images/vieworders.png',
    'assets/images/dashboard_images/vieworders.png',
    'assets/images/dashboard_images/vieworders.png',
  ];
  List titles = [
    'Add Products',
    'Edit Products',
    'Edit Categories',
    'View Orders',
    'View Orders',
  ];

  @override
  Widget build(BuildContext context) {
    // height = TDeviceUtils.getScreenHeight(context);
    // width = TDeviceUtils.getScreenWidth(context);
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                  height: TDeviceUtils.getScreenHeight(context) * 0.20,
                  width: TDeviceUtils.getScreenWidth(context),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 15,
                          left: 15,
                          right: 15,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {},
                              child: const Icon(
                                Icons.sort,
                                // color: TColors.white,
                                size: 40,
                              ),
                            ),
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                // color: TColors.white,
                              ),
                              child: const Icon(
                                Icons.person,
                                size: 40,
                                // color: TColors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 15,
                          left: 20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Dashboard',
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            Text(
                              'Last Update: 7 Aug 2023',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
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
                  height: TDeviceUtils.getScreenHeight(context) * 0.80,
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
                              Navigator.pushNamed(context, '/viewOrders');
                              break;
                            case 3:
                              Navigator.pushNamed(context, '/viewOrders');
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
