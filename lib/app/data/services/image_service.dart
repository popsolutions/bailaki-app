import 'package:odoo_client/app/data/models/image_dto.dart';
import 'package:odoo_client/app/data/models/memory_image.dart';

abstract class ImageService {
  Future<List<Photo>> findByPartner(int partnerId);
  Future<int> sendFile(ImageDto imageDto);
  Future<void> removeImage(int id);
}
