import 'dart:convert';
import 'dart:typed_data';

class Photo {
  final int id;
  final String name;
  final Uint8List bytes;

  Photo({this.id, this.name, this.bytes});

  factory Photo.fromJsonImage(String image) {
    return Photo.fromJson({'id':0, 'image': image});
  }

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
        id: json["id"],
        bytes: json["image"] is! bool
            ? base64.decode(base64.normalize(json['image'].replaceAll('\n', '')))
            : null);
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'image': base64Encode(bytes)};
}
