import 'package:latlng/latlng.dart';

class Partner {
  int id;
  String name;
  String imageUrl;
  DateTime birthdate;

  Partner({
    this.id,
    this.name,
    this.imageUrl,
    this.birthdate,
  });

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
            ? DateTime.parse(json["birthdate"])
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
}
