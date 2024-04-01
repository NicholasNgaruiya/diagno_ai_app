import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerBottomSheet extends StatelessWidget {
  final void Function(XFile)? onGallerySelected;
  final void Function(XFile)? onCameraSelected;
  const ImagePickerBottomSheet({
    super.key,
    this.onGallerySelected,
    this.onCameraSelected,
  });

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
