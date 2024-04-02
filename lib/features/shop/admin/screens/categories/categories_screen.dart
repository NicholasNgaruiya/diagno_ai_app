import 'package:flutter/material.dart';
import 'package:restaurant_frontend/features/shop/admin/screens/categories/category_details_screen.dart';
import 'package:restaurant_frontend/utils/constants/colors.dart';
import 'package:restaurant_frontend/utils/local_storage/storage_utility.dart';

import '../../../../../data/shop/repositories/admin_repository.dart';
import '../../models/category_item.dart';
import 'add_category_screeen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final AdminRepository _adminRepository = AdminRepository();
  List<CategoryItem> categories = []; // List of CategoryItem objects
  bool isLoading = false;
  final String defaultUrl = '';

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    setState(() {
      isLoading = true;
    });
    try {
      final List<CategoryItem> categoryList = await _adminRepository.getCategories();
      print('fetched category list2$categoryList');
      print('fetched category list Item name ${categoryList.length}');

      setState(() {
        // categories = categoryList.map((category) => category.name).toList();
        categories = categoryList;
      });
    } catch (e) {
      print('Error fetching categories: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Edit Categories',
          ),
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: TColors.primaryColor,
                ),
              )
            : ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: TColors.primaryColor,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 32,
                        backgroundImage: NetworkImage(
                          categories[index].image ??
                              'https://www.google.com/search?client=ubuntu-sn&hs=gJ2&sa=X&sca_esv=9a71a41fad6c3417&sca_upv=1&channel=fs&biw=1920&bih=995&sxsrf=ACQVn0-unZqiOTC2RMPCAuuj41URFJqRHQ:1711981283919&si=AKbGX_paaCugDdYkuX2heTJMr0_FGRox2AzKVmiTg2eQr2d-rnKq70LLmgXYOMzLtvEbExzSwMLcP28qgB2GyZcGLa_FPg7vJ_17grm_eQJMMb2rrkPpiRFzgqNHBp-47eWUDSMMGcNFdA6cliBc47QEJx_11QZWNKFtA1i15fM1pp85fPD8rB_OMuZ_OMFXiesxa1nKtiqJDtteEQ6Ev77RLrm3iOd_LYzSpAUPGjg5Vjdj2pRnikHhyZ4V9QU8ZwEqSJ9b3BAN7C2zjGXRPMJB5wwdyn5MnHgAazjlD6RMK62WDIuKAEvQ2QAhrGdnWLRN7NW-Sozx3E_jhLpbxXChLQdoSRx_fA%3D%3D&q=Pizza&lei=68IKZovBHvGAxc8PlbCEmAo#',
                        ),
                      ),
                      contentPadding: const EdgeInsets.all(8),
                      title: Text(categories[index].name),
                      onTap: () async {
                        print(categories[index].id);
                        TLocalStorage.saveString('selectedCategoryId', categories[index].id);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryDetailsScreen(
                              categories: categories[index],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print(categories.length);
            print('floating action button clicked');
            Navigator.pushNamed(context, '/addCategoryScreen');
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
