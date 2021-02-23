class UserProfileDto {
  final String name;
  final String email;
  final String imageUrl;
  final int age;
  final String bio;
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
  final String birth;
  final String gender;

  UserProfileDto(
      {this.age,
      this.bio,
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
      this.birth,
      this.gender,
      this.name,
      this.email,
      this.imageUrl});

  factory UserProfileDto.fromJson(Map<String, dynamic> json) {
    return UserProfileDto(
      name: json['name'] is! bool ? json['name'] : "",
      imageUrl: '',
      email: json['email'] is! bool ? json['email'] : "",
    );
  }
}
