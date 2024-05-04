// import 'package:flutter/material.dart';
// import 'package:restaurant_frontend/utils/device/device_utility.dart';
// import 'package:scroll_snap_list/scroll_snap_list.dart';

// class AppDetailsList extends StatefulWidget {
//   const AppDetailsList({super.key});

//   @override
//   State<AppDetailsList> createState() => _AppDetailsListState();
// }

// class _AppDetailsListState extends State<AppDetailsList> {
//   final List<Map<String, dynamic>> details = [
//     {
//       'title': 'Feature 1',
//       'description': 'Description of Feature 1',
//       'icon': Icons.lens,
//     },
//     {
//       'title': 'Feature 2',
//       'description': 'Description of Feature 2',
//       'icon': Icons.lens,
//     },
//     {
//       'title': 'Feature 3',
//       'description': 'Description of Feature 3',
//       'icon': Icons.lens,
//     },
//     // Add more detail maps as needed
//   ];

//   // int focusedIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       // color: Colors.red,
//       height: 200, // Adjust the height as needed
//       child: ScrollSnapList(
//         scrollDirection: Axis.horizontal,
//         itemSize: 200, // Adjust the item size as needed
//         itemBuilder: _buildListItem,
//         itemCount: details.length, // Use the length of the details list
//         onItemFocus: (index) {
//           print('$index item on focus');
//         },

//         // dynamicItemSize: true,
//       ),
//     );
//   }

//   Widget _buildListItem(BuildContext context, int index) {
//     final detail = details[index];

//     return Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         SizedBox(
//           // height: itemHeight,
//           width: TDeviceUtils.getScreenWidth(context) * 0.8,
//           child: Card(
//             color: Colors.blue[200],
//             elevation: 3,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Icon(detail['icon']), // Use icon from detail map
//                   const SizedBox(height: 10),
//                   Text(
//                     detail['title'], // Use title from detail map
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                     ),
//                   ),
//                   const SizedBox(height: 5),
//                   Text(
//                     detail['description'], // Use description from detail map
//                     style: const TextStyle(fontSize: 14),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
