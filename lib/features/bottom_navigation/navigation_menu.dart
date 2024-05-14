import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../utils/constants/colors.dart';
import '../../utils/helpers/helper_functions.dart';
import '../diagnosis/screens/symptoms_page.dart';
import '../home/home_page.dart';
import '../profile/profile_screen.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  int selectedIndex = 0;
  final screens = [
    // const Dashboard(),
    // Container(
    //   color: Colors.orange,
    // ),
    const HomePageScreen(),

    const SymptomsEntryPage(),
    // Container(
    //   color: Colors.orange,
    // ),
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          labelTextStyle: MaterialStateProperty.resolveWith<TextStyle>(
            (Set<MaterialState> states) => states.contains(MaterialState.selected)
                ? const TextStyle(color: TColors.primaryColor, fontWeight: FontWeight.w500, fontSize: 10)
                : TextStyle(color: darkMode ? TColors.white : TColors.black, fontWeight: FontWeight.w400, fontSize: 10),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            // color: darkMode ? TColors.black : Colors.grey[300],
            color: darkMode ? TColors.black : TColors.white,
            border: const Border(top: BorderSide(color: Colors.grey)),
          ),
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
              indicatorColor: darkMode ? Colors.transparent : Colors.transparent,
              // indicatorShape: StadiumBorder(),
              destinations: [
                NavigationDestination(
                  icon: Icon(
                    Iconsax.home,
                    size: 20,
                    color: selectedIndex == 0 ? TColors.primaryColor : null,
                  ),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(
                    size: 20,
                    Iconsax.search_favorite,
                    color: selectedIndex == 1 ? TColors.primaryColor : null,
                  ),
                  label: 'diagnose',
                ),
                // NavigationDestination(
                //   icon: Icon(
                //     size: 20,
                //     // Iconsax.receipt,
                //     Iconsax.book,
                //     color: selectedIndex == 2 ? TColors.primaryColor : null,
                //   ),
                //   label: 'History',
                // ),
                NavigationDestination(
                  icon: Icon(
                    size: 20,
                    Iconsax.user,
                    color: selectedIndex == 3 ? TColors.primaryColor : null,
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
