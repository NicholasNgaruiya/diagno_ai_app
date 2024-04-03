import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:restaurant_frontend/utils/constants/colors.dart';
import 'package:restaurant_frontend/utils/helpers/helper_functions.dart';

import 'features/shop/admin/screens/dashboard/dashboard.dart';
import 'features/shop/customer/screens/shop_screen.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  int selectedIndex = 0;
  final screens = [
    const Dashboard(),
    const ShopScreen(),
    Container(
      color: Colors.purple,
    ),
    Container(
      color: Colors.orange,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          labelTextStyle: MaterialStateProperty.resolveWith<TextStyle>(
            (Set<MaterialState> states) => states.contains(MaterialState.selected)
                ? const TextStyle(color: TColors.primaryColor, fontWeight: FontWeight.w500)
                : TextStyle(color: darkMode ? TColors.white : TColors.black, fontWeight: FontWeight.w400),
          ),
        ),
        child: Container(
          color: darkMode ? TColors.black : TColors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: NavigationBar(
              // animationDuration: const Duration(milliseconds: 1000),
              height: 60,
              elevation: 0,
              selectedIndex: selectedIndex,
              onDestinationSelected: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              backgroundColor: darkMode ? TColors.black : TColors.white,
              // indicatorColor: darkMode ? TColors.primaryColor.withOpacity(0.1) : TColors.primaryColor.withOpacity(0.1),
              indicatorColor: darkMode ? TColors.primaryColor : TColors.primaryColor,
              // indicatorShape: StadiumBorder(),
              destinations: const [
                NavigationDestination(
                  icon: Icon(
                    Iconsax.home,
                    // color: selectedIndex == 0 ? TColors.primaryColor : null,
                  ),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(
                    Iconsax.shop,
                    // color: selectedIndex == 1 ? TColors.primaryColor : null,
                  ),
                  label: 'Shop',
                ),
                NavigationDestination(
                  icon: Icon(
                    Iconsax.shopping_cart,
                    // color: selectedIndex == 2 ? TColors.primaryColor : null,
                  ),
                  label: 'Cart',
                ),
                NavigationDestination(
                  icon: Icon(
                    Iconsax.user,
                    // color: selectedIndex == 3 ? TColors.primaryColor : null,
                  ),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
      body: screens[selectedIndex],
    );
  }
}
