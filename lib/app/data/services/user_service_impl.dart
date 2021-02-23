import 'package:odoo_client/app/data/models/update_profile_dto.dart';
import 'package:odoo_client/app/data/models/profile_dto.dart';
import 'package:odoo_client/app/data/pojo/basic_user_dto.dart';
import 'package:odoo_client/app/data/pojo/user.dart';
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
      'gender'
    ]);
    final json = response.getResult()['records'][0];
    return ProfileDto.fromJson(json);
  }

  @override
  Future<void> update(UpdateProfileDto updateProfileDto) async {
    final response = await _odoo.write(
        'res.partner', [updateProfileDto.partnerId], updateProfileDto.toJson());
    print(response);
  }
}
