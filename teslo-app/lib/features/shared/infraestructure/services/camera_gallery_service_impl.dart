import 'package:image_picker/image_picker.dart';
import 'package:teslo_shop/features/shared/infraestructure/services/camera_gallery_service.dart';

class CameraGalleryServiceImpl implements CameraGalleryService {
  final ImagePicker _picker = ImagePicker();

  @override
  Future<String?> takePhoto() async {
    final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
        preferredCameraDevice: CameraDevice.rear);

    if (photo == null) return null;
    return photo.path;
  }

  @override
  Future<String?> selectPhoto() async {
    final XFile? photo =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    if (photo == null) return null;
    return photo.path;
  }
}
