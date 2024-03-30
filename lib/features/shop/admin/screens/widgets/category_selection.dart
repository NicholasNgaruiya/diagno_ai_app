// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:flutter/material.dart';
// import 'package:restaurant_frontend/features/shop/admin/models/category_item.dart';

// import '../../../../../data/shop/repositories/admin_repository.dart';
// import '../../../../../data/shop/services/admin_shop_service.dart';

// class CategorySelection extends StatefulWidget {
//   const CategorySelection({super.key});

//   @override
//   State<CategorySelection> createState() => _CategorySelectionState();
// }

// class _CategorySelectionState extends State<CategorySelection> {
//   final AdminRepository _adminRepository = AdminRepository(AdminShopService());
//   List<CategoryItem> categories = [];
//   List<CategoryItem> searchCategory = [];

//   @override
//   void initState() {
//     init();
//     super.initState();
//   }

//   void init() async {
//     final List<CategoryItem> fetchedCategories = await _adminRepository.getCategories();
//     categories = fetchedCategories;
//   }

//   List<CategoryItem> filterSearchCategory(String query) {
//     // searchCategory = categories.where((category) => category.categoryName.toLowerCase().contains(query.toLowerCase())).toList();
//     List<CategoryItem> items = [];
//     if (query.isNotEmpty) {
//       items = categories.where((element) => element.name.toLowerCase().contains(query.toLowerCase())).toList();
//     }
//     return items;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: DropdownSearch(
//             mode: Mode.MENU,
//             showSearchBox: true,
//             isFilteredOnline: true,
//             dropDownButton: const Icon(
//               Icons.keyboard_arrow_down,
//               color: Colors.grey,
//               size: 18,
//             ),
//             dropdownSearchDecoration: const InputDecoration(
//               hintText: 'Search Category',
//             ),
//             showClearButton: false,
//             onFind: (value) async {
//               setState(() {});
//               return filterSearchCategory(value ?? '');
//             },
//             onChanged: (value) {
//               setState(() {
//                 searchCategory = [value ?? categories[0]];
//               });
//             },
//             clearButtonBuilder: (_) => const Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Icon(
//                 Icons.clear,
//                 size: 17,
//                 color: Colors.black,
//               ),
//             ),
//           ),
//         ),
//         Expanded(
//           child: ListView.builder(
//             itemCount: searchCategory.length,
//             itemBuilder: (context, index) {
//               return ListTile(
//                 title: Text(searchCategory[index].name),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
