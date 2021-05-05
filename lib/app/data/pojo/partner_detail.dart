import 'package:latlng/latlng.dart';
import 'package:odoo_client/app/data/models/memory_image.dart';

class PartnerDetail {
  final int age;
  final String bio;
  final String name;
  final String email;
  final String phone;
  final String city;
  final String title;
  final String website;
  final String jobPosition;
  final String country;
  final DateTime birthdate;
  final String gender;
  final String activityState;
  final LatLng position;
  final List<Photo> images;

  PartnerDetail(
      {this.position,
      this.activityState,
      this.age,
      this.bio,
      this.name,
      this.email,
      this.phone,
      this.city,
      this.title,
      this.website,
      this.jobPosition,
      this.country,
      this.birthdate,
      this.gender,
      this.images});

  factory PartnerDetail.fromJson(Map<String, dynamic> json) {
    return PartnerDetail(
        age: json["age"] is! bool ? json['age'] : "N/A",
        bio: json["comment"] is! bool ? json["comment"] : "N/A",
        name: json["name"],
        email: json["email"] is! bool ? json["email"] : "N/A",
        phone: json['phone'] is! bool ? json['phone'] : "N/A",
        city: json['city'] is! bool ? json['city'] : "",
        title: json['title'] is! bool ? json['title'][1] : "N/A",
        website: json['website'] is! bool ? json['website'] : "N/A",
        jobPosition: json['function'] is! bool ? json['function'] : "N/A",
        birthdate:
            json['birthdate_date'] is! bool && json['birthdate_date'] != null
                ? DateTime.parse(json['birthdate_date'])
                : null,
        gender: json['gender'] is! bool ? json['gender'] : "N/A",
        activityState:
            json['activity_state'] is! bool ? json['activity_state'] : "N/A",
        position: json["partner_current_latitude"] is! bool &&
                json["partner_current_longitude"] is! bool
            ? LatLng(
                json["partner_current_latitude"],
                json["partner_current_longitude"],
              )
            : null,
        images: json["images"].map<Photo>((e) => Photo.fromJson(e)).toList());
  }
}
