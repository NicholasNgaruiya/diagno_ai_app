import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/image_picker_helper.dart';

class ImageSelectorWidget extends StatefulWidget {
  final void Function(File)? onImageSelected;
  final String? imageUrl;
  const ImageSelectorWidget({super.key, this.onImageSelected, this.imageUrl});

  @override
  State<ImageSelectorWidget> createState() => _ImageSelectorWidgetState();
}

class _ImageSelectorWidgetState extends State<ImageSelectorWidget> {
  XFile? _image;

  Future<void> _getImageFromGallery() async {
    final XFile? image = await TImagePickerHelper.getImageFromGallery();

    setState(() {
      _image = image;
    });
    if (widget.onImageSelected != null && image != null) {
      widget.onImageSelected!(File(image.path));
    }
  }

  Future<void> _getImageFromCamera() async {
    final XFile? image = await TImagePickerHelper.getImageFromCamera();

    setState(() {
      _image = image;
    });
    if (widget.onImageSelected != null && image != null) {
      widget.onImageSelected!(File(image.path));
    }
  }

  void _showImagePickerModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(
                  Icons.photo_library,
                  color: TColors.black,
                ),
                title: const Text(
                  'Choose from gallery',
                  style: TextStyle(
                    color: TColors.black,
                  ),
                ),
                onTap: () {
                  _getImageFromGallery();
                  Navigator.of(context).pop();
                },
              ),
              const Divider(
                indent: 20,
                endIndent: 20,
              ),
              ListTile(
                leading: const Icon(
                  Icons.photo_camera,
                  color: TColors.black,
                ),
                title: const Text(
                  'Take a photo',
                  style: TextStyle(
                    color: TColors.black,
                  ),
                ),
                onTap: () {
                  _getImageFromCamera();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _image == null
            ? InkWell(
                onTap: () {
                  _showImagePickerModal(context);
                },
                child: Container(
                  height: 150,
                  width: 200,
                  // width: TDeviceUtils.getScreenWidth(context) * 0.9,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    // color: Colors.grey[200],
                    image: DecorationImage(
                      image: widget.imageUrl != null && widget.imageUrl!.isNotEmpty
                          ? NetworkImage(widget.imageUrl!)
                          : const AssetImage('assets/images/products_images/noImageBackground.png') as ImageProvider<Object>,
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                    child: _image == null && (widget.imageUrl == null || widget.imageUrl!.isEmpty)
                        ? const Text(
                            'No Image Selected',
                            style: TextStyle(
                              color: TColors.black,
                              fontSize: 18,
                            ),
                          )
                        : null,
                  ),
                ),
              )
            : InkWell(
                onTap: () => _showImagePickerModal(context),
                child: Container(
                  height: 150,
                  // width: TDeviceUtils.getScreenWidth(context) * 0.9,
                  width: 200,
                  decoration: const BoxDecoration(
                    border: Border.fromBorderSide(
                      BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: Image.file(
                    File(
                      _image!.path,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
        Positioned(
          bottom: 0,
          right: 0,
          child: IconButton(
            onPressed: () {
              _showImagePickerModal(context);
            },
            icon: const Icon(
              Icons.add_a_photo,
              size: 35,
              color: TColors.white,
            ),
          ),
        ),
      ],
    );
  }
}
