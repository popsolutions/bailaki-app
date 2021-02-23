class ProfileDto {
  final String profile_description;
  final List<int> music_genre_ids;
  final int music_skill_id;
  final String function;
  final DateTime birthdate_date;
  final String gender;

  ProfileDto({
    this.profile_description,
    this.music_genre_ids,
    this.music_skill_id,
    this.function,
    this.birthdate_date,
    this.gender,
  });

  factory ProfileDto.fromJson(Map<String, dynamic> json) {
    return ProfileDto(
        birthdate_date:
            json['birthdate_date'] is! bool ? json['birthdate_date'] : null,
        function: json['function'] is! bool ? json['function'] : null,
        gender: json['gender'] is! bool ? json['gender'] : null,
        music_genre_ids:
            json['music_genre_ids'] is! bool ? List<int>.from(json['music_genre_ids']): null,
        music_skill_id:
            json['music_skill_id'] is! bool ? json['music_skill_id'] : null,
        profile_description: json['profile_description'] is! bool
            ? json['profile_description']
            : null);
  }
}
