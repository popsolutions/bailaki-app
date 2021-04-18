import 'dart:convert';

import 'package:odoo_client/app/data/models/image_dto.dart';
import 'package:odoo_client/app/data/models/memory_image.dart';
import 'package:odoo_client/app/data/services/image_service.dart';
import 'package:odoo_client/app/data/services/odoo_api.dart';

class ImageServiceImpl implements ImageService {
  final Odoo _odoo;

  ImageServiceImpl(this._odoo);

  @override
  Future<int> sendFile(ImageDto imageDto) async {
    final response = await _odoo.create(
      'res.partner.image',
      {
        'name': imageDto.name,
        'image': base64.encode(imageDto.bytes),
      },
    );
    final imageId = response.getResult();
    final linkResponse = await _odoo.write(
      'res.partner',
      [imageDto.partnerId],
      {
        'res_partner_image_ids': [
          [4, imageId]
        ]
      },
    );
    print(linkResponse);
    return imageId;
  }

  @override
  Future<void> removeImage(int id) async {
    final response = await _odoo.unlink('res.partner.image', [id]);
    print(response);
  }

  @override
  Future<List<Photo>> findByPartner(int partnerId) async {
    final response = await _odoo.searchRead('res.partner.image', [
      ['res_partner_id', '=', partnerId]
    ], []);
    final items =
        response.getRecords().map<Photo>((e) => Photo.fromJson(e)).toList();
    return items;
  }
}
