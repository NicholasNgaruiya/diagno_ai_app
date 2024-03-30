import 'package:flutter/material.dart';

class SelectCategorywidget extends StatefulWidget {
  final void Function(String)? onCategorySelected; // Callback function
  final void Function()? onClear; // Callback function to clear the category field
  const SelectCategorywidget({super.key, this.onCategorySelected, this.onClear});

  @override
  State<SelectCategorywidget> createState() => _SelectCategorywidgetState();
}

class _SelectCategorywidgetState extends State<SelectCategorywidget> {
  String? dropDownValue;
  var items = [
    'Drinks',
    'Food',
    'Snacks',
    'Others',
  ];
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
        items: items.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items),
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
        onChanged: (String? selectedCategory) {
          setState(() {
            dropDownValue = selectedCategory!;
          });
          // Call the callback function with the selected category
          if (widget.onCategorySelected != null) {
            widget.onCategorySelected!(selectedCategory!);
          }
        },
      ),
    );
  }

  // Method to clear the category field
  void clearCategory() {
    setState(() {
      dropDownValue = null;
    });
  }
}
