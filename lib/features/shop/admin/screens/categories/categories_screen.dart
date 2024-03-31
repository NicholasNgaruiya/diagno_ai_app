import 'package:flutter/material.dart';
import 'package:restaurant_frontend/features/shop/admin/screens/categories/category_details_screen.dart';
import 'package:restaurant_frontend/utils/constants/colors.dart';

import '../../../../../data/shop/repositories/admin_repository.dart';
import '../../models/category_item.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final AdminRepository _adminRepository = AdminRepository();
  List<CategoryItem> categories = []; // List of CategoryItem objects
  bool isLoading = false;

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
                        backgroundImage: NetworkImage(categories[index].image ?? 'assets/images/dashboard_images/add-item.png'),
                      ),
                      contentPadding: const EdgeInsets.all(8),
                      title: Text(categories[index].name),
                      onTap: () {
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
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
