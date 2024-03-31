import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
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
        body: AnimatedList(
          initialItemCount: categories.length,
          itemBuilder: (context, index, animation) => Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            child: const ListTile(
              contentPadding: EdgeInsets.all(8),
              // title: Text(categories[index].name),
              // trailing: IconButton(
              //   icon: const Icon(Icons.delete),
              //   onPressed: () async {},
              // ),
            ),
          ),
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
