class PartnerDetail {
  final int age;
  final String bio;
  final String name;
  final String email;
  final String phone;
  final String mobile;
  final String street;
  final String street2;
  final String city;
  final String stateId;
  final String zip;
  final String title;
  final String website;
  final String jobPosition;
  final String country;
  final String imageUrl;
  final String birth;
  final String gender;

  PartnerDetail({
    this.age,
    this.bio,
    this.name,
    this.email,
    this.phone,
    this.mobile,
    this.street,
    this.street2,
    this.city,
    this.stateId,
    this.zip,
    this.title,
    this.website,
    this.jobPosition,
    this.country,
    this.imageUrl,
    this.birth,
    this.gender,
  });

  factory PartnerDetail.fromJson(Map<String, dynamic> json) {
    return PartnerDetail(
        age: json["age"] is! bool ? json['age'] : "N/A",
        bio: json["comment"] is! bool ? json["comment"] : "N/A",
        name: json["name"],
        email: json["email"] is!  bool ? json["email"] : "N/A",
        phone: json['phone'] is! bool ? json['phone'] : "N/A",
        mobile: json['mobile'] is! bool ? json['mobile'] : "N/A",
        street: json['street'] is! bool ? json['street'] : "",
        street2: json['street2'] is! bool ? json['street2'] : "",
        city: json['city'] is! bool ? json['city'] : "",
        stateId: json['state_id'] is! bool ? json['state_id'][1] : "",
        zip: json['zip'] is! bool ? json['zip'] : "",
        title: json['title'] is! bool ? json['title'][1] : "N/A",
        website: json['website'] is! bool ? json['website'] : "N/A",
        jobPosition: json['function'] is! bool ? json['function'] : "N/A",
        country: json["country_id"] is! bool ? json["country_id"][1] : "N/A",
        imageUrl: '',
        birth: json['birthdate_date'] is! bool ? json['birthdate_date'] : "N/A",
        gender: json['gender'] is! bool ? json['gender'] : "N/A");
  }
}
