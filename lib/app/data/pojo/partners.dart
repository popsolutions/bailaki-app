
class Partner {
  int id;
  String name;
  String imageUrl;
  String email;
  String phone;
  String address;
  String birth;
  String gender;

  Partner(
      {this.id,
      this.name,
      this.imageUrl,
      this.email,
      this.phone,
      this.address,
      this.birth,
      this.gender});

  Partner.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    email = json["email"] is! bool ? json["email"] : "N/A";
    name = json["name"];
    phone = json["phone"] is! bool ? json["phone"] : "N/A";
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
