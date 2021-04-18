import 'dart:convert';
import 'dart:typed_data';

class Photo {
  final int id;
  final String name;
  final Uint8List bytes;

  Photo({this.id, this.name, this.bytes});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
        id: json["id"],
        bytes: json["image"] is! bool
            ? base64.decode(base64.normalize(json['image']))
            : null);
  }
}
