import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class SelectAndSaveImage {
  SelectAndSaveImage._();
  static final ImagePicker _picker = ImagePicker();

  static Future<String?> call({required ImageSource source}) async {
    final XFile? imagePicked = await _picker.pickImage(
      source: source,
      preferredCameraDevice: CameraDevice.rear,
    );

    if (imagePicked != null) {
      final image = await getApplicationDocumentsDirectory();
      final imagePath = "${image.path}/${imagePicked.name}";
      await imagePicked.saveTo(imagePath);
      return imagePath;
    }
    return null;
  }
}
