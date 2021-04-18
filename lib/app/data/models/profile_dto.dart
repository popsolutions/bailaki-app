import 'package:latlng/latlng.dart';
import 'package:odoo_client/app/data/models/memory_image.dart';

class ProfileDto {
  final String profile_description;
  final List<int> music_genre_ids;
  final int music_skill_id;
  final String function;
  final DateTime birthdate_date;
  final String gender;
  final int refferedFriendMaxDistance;
  final String city;
  final String activityState;
  final LatLng position;
  final bool interestMales;
  final bool interestFemales;
  final bool interestOtherGenres;
  final List<Photo> images;
  final bool enableMessageNotification;
  final bool enableMatchNotification;
  final int referredFriendMinAge;
  final int referredFriendMaxAge;
  final List<int> referredFriendsIds;

  ProfileDto(
      {this.interestMales,
      this.interestFemales,
      this.interestOtherGenres,
      this.city,
      this.activityState,
      this.position,
      this.refferedFriendMaxDistance,
      this.profile_description,
      this.music_genre_ids,
      this.music_skill_id,
      this.function,
      this.birthdate_date,
      this.gender,
      this.images,
      this.enableMessageNotification,
      this.enableMatchNotification,
      this.referredFriendMinAge,
      this.referredFriendMaxAge,
      this.referredFriendsIds});

  factory ProfileDto.fromJson(Map<String, dynamic> json) {
    return ProfileDto(
        birthdate_date: json['birthdate_date'] is! bool
            ? DateTime.parse(json['birthdate_date'])
            : null,
        function: json['function'] is! bool ? json['function'] : null,
        gender: json['gender'] is! bool ? json['gender'] : null,
        music_genre_ids: json['music_genre_ids'] is! bool
            ? List<int>.from(json['music_genre_ids'])
            : null,
        music_skill_id:
            json['music_skill_id'] is! bool ? json['music_skill_id'][0] : null,
        profile_description: json['profile_description'] is! bool
            ? json['profile_description']
            : null,
        refferedFriendMaxDistance: json['referred_friend_max_distance'] is! bool
            ? json['referred_friend_max_distance']
            : 0,
        city: json["city"] is! bool ? json["city"] : "N/A",
        activityState:
            json["activity_state"] is! bool ? json["activity_state"] : "N/A",
        position: json["partner_current_latitude"] is! bool &&
                json["partner_current_longitude"] is! bool
            ? LatLng(
                json["partner_current_latitude"],
                json["partner_current_longitude"],
              )
            : null,
        interestFemales: json["interest_female_gender"],
        interestMales: json["interest_male_gender"],
        interestOtherGenres: json["interest_other_genres"],
        images: json["images"]?.map<Photo>((e) => Photo.fromJson(e))?.toList(),
        enableMatchNotification: json["enable_match_notification"],
        enableMessageNotification: json["enable_message_notification"],
        referredFriendMaxAge: json["referred_friend_max_age"] is! bool
            ? json["referred_friend_max_age"]
            : null,
        referredFriendMinAge: json["referred_friend_min_age"] is! bool
            ? json["referred_friend_min_age"]
            : null,
        referredFriendsIds: List<int>.from(json['referred_friend_ids']));
  }
}
