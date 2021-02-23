class UserBasicDto {
  final String name;
  final String email;
  final String imageUrl;

  UserBasicDto({this.name, this.email, this.imageUrl});

  factory UserBasicDto.fromJson(Map<String, dynamic> json) {
    return UserBasicDto(
      name: json['name'] is! bool ? json['name'] : "",
      imageUrl: '',
      email: json['email'] is! bool ? json['email'] : "",
    );
  }
}
