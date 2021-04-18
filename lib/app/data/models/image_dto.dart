import 'dart:typed_data';

class ImageDto {
  final int partnerId;
  final String name;
  final Uint8List bytes;

  ImageDto(this.partnerId, this.name, this.bytes);
}
