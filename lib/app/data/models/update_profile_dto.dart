class UpdateProfileDto {
  final int partnerId;
  final String profile_description;
  final List<int> music_genre_ids;
  final int music_skill_id;
  final String function;
  final DateTime birthdate_date;
  final String gender;

  UpdateProfileDto({
    this.profile_description,
    this.music_genre_ids,
    this.music_skill_id,
    this.function,
    this.birthdate_date,
    this.gender,
    this.partnerId,
  });

  Map<String, dynamic> toJson() => {
        'profile_description': profile_description,
        'music_genre_ids': music_genre_ids,
        'music_skill_id': music_skill_id,
        'function': function,
        'birthdate_date': birthdate_date,
        'gender': gender
      };
}
