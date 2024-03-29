import 'package:latlng/latlng.dart';
import 'package:odoo_client/app/data/models/memory_image.dart';

class Partner {
  int id;
  String name;
  String imageUrl;
  DateTime birthdate;
  LatLng position;
  List<Photo> photos;

  Partner({this.id, this.name, this.imageUrl, this.birthdate, this.position});

  Photo get avatarPhoto => photos.isEmpty ? null : photos.first;

/*
      'name',
      'birthdate_date'
      'partner_current_latitude',
      'partner_current_longitude',
*/
  Partner.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    birthdate =
        json["birthdate_date"] is! bool && json["birthdate_date"] != null
            ? DateTime.parse(json["birthdate_date"])
            : null;

    position = json["partner_current_latitude"] is! bool &&
            json["partner_current_longitude"] is! bool
        ? LatLng(
            json["partner_current_latitude"],
            json["partner_current_longitude"],
          )
        : null;

    imageUrl =
        'https://assets.b9.com.br/wp-content/uploads/2020/09/Batman-issue86-heder-1280x677.jpg';

    /*
    '$SERVER_URL/web/image?model=res.partner&field=image&' +
        session +
        "&id=" +
        i["id"].toString();
        */
  }

  int get Age => (DateTime.now().difference(birthdate).inDays / 365).truncate();
}
