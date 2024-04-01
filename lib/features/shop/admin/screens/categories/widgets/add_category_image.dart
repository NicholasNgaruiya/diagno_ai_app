// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:restaurant_frontend/common/widgets/dashboard/image_selector.dart';
// import 'package:restaurant_frontend/utils/device/device_utility.dart';

// import '../../../../../../../utils/constants/colors.dart';

// class AddCategoryImage extends StatefulWidget {
//   // final void Function()? onClear; // Callback function to clear the displayed image
//   // final void Function(File)? onImageSelected;
//   final String? categoryImageUrl; // New parameter to accept category image URL
//   const AddCategoryImage({super.key, this.categoryImageUrl});

//   @override
//   State<AddCategoryImage> createState() => _AddCategoryImageState();
// }

// class _AddCategoryImageState extends State<AddCategoryImage> {
//   // final ImagePicker _picker = ImagePicker();
//   // XFile? _image;
//   @override
//   Widget build(BuildContext context) {
//     return ImageSelectorWidget();
//     // return Stack(
//     //   children: [
//     //     _image == null
//     //         ? InkWell(
//     //             onTap: () {
//     //               _showImagePickerModal(context);
//     //             },
//     //             child: Container(
//     //               // height: 200,
//     //               // width: TDeviceUtils.getScreenWidth(context) * 0.9,
//     //               height: 150,
//     //               width: 200,
//     //               decoration: BoxDecoration(
//     //                 border: Border.all(
//     //                   color: Colors.grey,
//     //                 ),
//     //                 borderRadius: BorderRadius.circular(10),
//     //                 // color: Colors.grey[200],
//     //                 image: DecorationImage(
//     //                   image: widget.categoryImageUrl != null && widget.categoryImageUrl!.isNotEmpty
//     //                       ? NetworkImage(widget.categoryImageUrl!)
//     //                       : const AssetImage('assets/images/products_images/noImageBackground.png') as ImageProvider<Object>,
//     //                   fit: BoxFit.cover,
//     //                 ),
//     //               ),
//     //               child:
//     //                   // const Center(
//     //                   //   child: Text(
//     //                   //     'No Image Selected',
//     //                   //     style: TextStyle(
//     //                   //       color: TColors.black,
//     //                   //       fontSize: 18,
//     //                   //     ),
//     //                   //   ),
//     //                   // ),
//     //                   Center(
//     //                 child: _image == null && (widget.categoryImageUrl == null || widget.categoryImageUrl!.isEmpty)
//     //                     ? const Text(
//     //                         'No Image Selected',
//     //                         style: TextStyle(
//     //                           color: TColors.black,
//     //                           fontSize: 18,
//     //                         ),
//     //                       )
//     //                     : null, // Do not show any text if there's an image
//     //               ),
//     //             ),
//     //           )
//     //         : InkWell(
//     //             onTap: () => _showImagePickerModal(context),
//     //             child: Container(
//     //               height: 150,
//     //               width: 200,
//     //               // height: 200,
//     //               // width: TDeviceUtils.getScreenWidth(context) * 0.9,
//     //               decoration: const BoxDecoration(
//     //                 border: Border.fromBorderSide(
//     //                   BorderSide(
//     //                     color: Colors.grey,
//     //                     width: 1.0,
//     //                   ),
//     //                 ),
//     //               ),
//     //               child: Image.file(
//     //                 File(
//     //                   _image!.path,
//     //                 ),
//     //                 fit: BoxFit.cover,
//     //               ),
//     //             ),
//     //           ),
//     //     Positioned(
//     //       bottom: 0,
//     //       right: 0,
//     //       child: IconButton(
//     //         onPressed: () {
//     //           _showImagePickerModal(context);
//     //         },
//     //         icon: const Icon(
//     //           Icons.add_a_photo,
//     //           size: 35,
//     //           color: TColors.white,
//     //         ),
//     //       ),
//     //     ),
//     //   ],
//     // );
//     // }

// //   Future getImageFromGallery() async {
// //     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

// //     setState(() {
// //       _image = image;
// //     });
// //     if (widget.onImageSelected != null && image != null) {
// //       widget.onImageSelected!(File(image.path));
// //     }
// //   }

// //   Future getImageFromCamera() async {
// //     final XFile? image = await _picker.pickImage(source: ImageSource.camera);

// //     setState(() {
// //       _image = image;
// //     });
// //     if (widget.onImageSelected != null && image != null) {
// //       widget.onImageSelected!(File(image.path));
// //     }
// //   }

// //   void _showImagePickerModal(BuildContext context) {
// //     showModalBottomSheet(
// //       context: context,
// //       backgroundColor: Colors.transparent,
// //       builder: (BuildContext context) {
// //         return Container(
// //           margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
// //           decoration: BoxDecoration(
// //             color: Colors.white,
// //             borderRadius: BorderRadius.circular(16),
// //             boxShadow: [
// //               BoxShadow(
// //                 color: Colors.black.withOpacity(0.2),
// //                 spreadRadius: 3,
// //                 blurRadius: 5,
// //                 offset: const Offset(0, 3), // changes position of shadow
// //               ),
// //             ],
// //           ),
// //           child: Wrap(
// //             children: <Widget>[
// //               ListTile(
// //                 leading: const Icon(
// //                   Icons.photo_library,
// //                   color: TColors.black,
// //                 ),
// //                 title: const Text(
// //                   'Choose from gallery',
// //                   style: TextStyle(
// //                     color: TColors.black,
// //                   ),
// //                 ),
// //                 onTap: () {
// //                   getImageFromGallery();
// //                   Navigator.of(context).pop();
// //                 },
// //               ),
// //               const Divider(
// //                 indent: 20,
// //                 endIndent: 20,
// //               ),
// //               ListTile(
// //                 leading: const Icon(
// //                   Icons.photo_camera,
// //                   color: TColors.black,
// //                 ),
// //                 title: const Text(
// //                   'Take a photo',
// //                   style: TextStyle(
// //                     color: TColors.black,
// //                   ),
// //                 ),
// //                 onTap: () {
// //                   getImageFromCamera();
// //                   Navigator.of(context).pop();
// //                 },
// //               ),
// //             ],
// //           ),
// //         );
// //       },
// //     );
// //   }

// //   // Method to clear the displayed image
// //   void _clearImage() {
// //     setState(() {
// //       _image = null;
// //     });
// //   }
// // }
//   }
// }
