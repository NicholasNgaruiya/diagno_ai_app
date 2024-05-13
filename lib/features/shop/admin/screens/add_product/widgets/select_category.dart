import 'package:flutter/material.dart';

import '../../../../../../data/shop/repositories/admin_repository.dart';
import '../../../models/category_item.dart';

class SelectCategorywidget extends StatefulWidget {
  final void Function(String)? onCategorySelected; // Callback function
  final void Function()? onClear; // Callback function to clear the category field
  const SelectCategorywidget({super.key, this.onCategorySelected, this.onClear});

  @override
  State<SelectCategorywidget> createState() => _SelectCategorywidgetState();
}

class _SelectCategorywidgetState extends State<SelectCategorywidget> {
  String? dropDownValue;
  final AdminRepository _adminRepository = AdminRepository();
  // List<String> categories = [];
  List<CategoryItem> categories = []; // List of CategoryItem objects

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      final List<CategoryItem> categoryList = await _adminRepository.getCategories();
      print('fetched category list$categoryList');
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
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: DropdownButton(
        items: categories.map((CategoryItem category) {
          return DropdownMenuItem(
            value: category.id, //Pass the ID as the value
            child: Text(category.name),
          );
        }).toList(),
        isExpanded: true,
        underline: const SizedBox(),
        value: dropDownValue,
        hint: const Text('Select Category'),
        icon: const Icon(
          Icons.arrow_drop_down,
          size: 40,
        ),
        onChanged: (String? selectedCategoryId) {
          setState(() {
            dropDownValue = selectedCategoryId!;
          });
          // Call the callback function with the selected category ID
          if (widget.onCategorySelected != null) {
            widget.onCategorySelected!(selectedCategoryId!);
          }
        },
      ),
    );
  }

  // Method to clear the category field
  // void clearCategory() {
  //   setState(() {
  //     dropDownValue = null;
  //   });
  // }
}
