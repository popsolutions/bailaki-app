import 'package:odoo_client/app/data/models/memory_image.dart';
import 'package:odoo_client/app/data/models/update_profile_dto.dart';
import 'package:odoo_client/app/data/models/profile_dto.dart';
import 'package:odoo_client/app/data/pojo/basic_user_dto.dart';
import 'package:odoo_client/app/data/services/odoo_api.dart';
import 'package:odoo_client/app/data/services/user_service.dart';
import 'package:odoo_client/app/utility/strings.dart';

class UserServiceImpl implements UserService {
  final Odoo _odoo;

  UserServiceImpl(this._odoo);

  @override
  Future<UserBasicDto> findById(int id) async {
    final response = await _odoo.searchRead(Strings.res_users, [
      ["id", "=", id]
    ], []);

    final json = response.getResult()['records'][0];
    return UserBasicDto.fromJson(json);
  }

  @override
  Future<ProfileDto> findProfile(int partnerId) async {
    final response = await _odoo.searchRead('res.partner', [
      ["id", "=", partnerId]
    ], [
      'profile_description',
      'music_genre_ids',
      'music_skill_id',
      'function',
      'birthdate_date',
      'gender',
      'city',
      'activity_state',
      'referred_friend_max_distance',
      'partner_current_latitude',
      'partner_current_longitude',
      'interest_male_gender',
      'interest_female_gender',
      'interest_other_genres'
    ]);
    
    final photosResponse = await _odoo.searchRead('res.partner.image', [
      ['res_partner_id', '=', partnerId]
    ], [
      'id',
      'image'
    ]);
    final images = photosResponse.getRecords();
    final json = response.getResult()['records'][0];
    return ProfileDto.fromJson({...json,'images':images});
  }

  @override
  Future<void> update(UpdateProfileDto updateProfileDto) async {
    final response = await _odoo.write(
        'res.partner', [updateProfileDto.partnerId], updateProfileDto.toJson());
    print(response);
  }
}
