class UpdateProfileDto {
  final String name;
  final int partnerId;
  final String profile_description;
  final List<int> music_genre_ids;
  final int music_skill_id;
  final String function;
  final DateTime birthdate_date;
  final String gender;
  final int refferedFriendMaxDistance;
  final bool interestMaleGender;
  final bool interestFemaleGender;
  final bool interestOtherGenres;
  final bool enableMessageNotification;
  final bool enableMatchNotification;
  final int referredFriendMinAge;
  final int referredFriendMaxAge;
  final double partnerCurrentLatitude;
  final double partnerCurrentLongitude;

  UpdateProfileDto({
    this.name,
    this.interestMaleGender,
    this.interestFemaleGender,
    this.interestOtherGenres,
    this.refferedFriendMaxDistance,
    this.profile_description,
    this.music_genre_ids,
    this.music_skill_id,
    this.function,
    this.birthdate_date,
    this.gender,
    this.partnerId,
    this.enableMessageNotification,
    this.enableMatchNotification,
    this.referredFriendMinAge,
    this.referredFriendMaxAge,
    this.partnerCurrentLatitude,
    this.partnerCurrentLongitude,
  });

  Map<String, dynamic> toJson() => {
        if (name != null) 'name': name,
        if (refferedFriendMaxDistance != null)
          'referred_friend_max_distance': refferedFriendMaxDistance,
        if (interestMaleGender != null)
          'interest_male_gender': interestMaleGender,
        if (interestFemaleGender != null)
          'interest_female_gender': interestFemaleGender,
        if (interestOtherGenres != null)
          'interest_other_genres': interestOtherGenres,
        if (profile_description != null)
          'profile_description': profile_description,
        if (music_genre_ids != null)
          'music_genre_ids': [
            [6, 0, music_genre_ids]
          ],
        if (music_skill_id != null) 'music_skill_id': music_skill_id,
        if (function != null) 'function': function,
        if (birthdate_date != null) 'birthdate_date': birthdate_date.toString(),
        if (gender != null) 'gender': gender,
        if (enableMessageNotification != null)
          'enable_message_notification': enableMessageNotification,
        if (enableMatchNotification != null)
          'enable_match_notification': enableMatchNotification,
        if (referredFriendMinAge != null)
          'referred_friend_min_age': referredFriendMinAge,
        if (referredFriendMaxAge != null)
          'referred_friend_max_age': referredFriendMaxAge,
        if (partnerCurrentLatitude != null)
          'partner_current_latitude': partnerCurrentLatitude,
        if (partnerCurrentLongitude != null)
          'partner_current_longitude': partnerCurrentLongitude
      };
}
