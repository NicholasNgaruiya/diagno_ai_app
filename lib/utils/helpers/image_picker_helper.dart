import 'package:image_picker/image_picker.dart';

class TImagePickerHelper {
  static final ImagePicker _picker = ImagePicker();

  //get image from gallery
  static Future<XFile?> getImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  //get image from camera
  static Future<XFile?> getImageFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    return image;
  }
}
