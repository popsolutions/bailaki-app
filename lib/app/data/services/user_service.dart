import 'package:odoo_client/app/data/models/profile_dto.dart';
import 'package:odoo_client/app/data/models/update_profile_dto.dart';
import 'package:odoo_client/app/data/pojo/basic_user_dto.dart';

abstract class UserService {
  Future<UserBasicDto> findById(int id);
  Future<ProfileDto> findProfile(int partnerId);
  Future<void> update(UpdateProfileDto updateProfileDto);
}
