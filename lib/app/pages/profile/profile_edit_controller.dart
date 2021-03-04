import 'package:mobx/mobx.dart';
import 'package:odoo_client/app/data/models/memory_image.dart';
import 'package:odoo_client/app/data/models/update_profile_dto.dart';
import 'package:odoo_client/app/data/pojo/music_genre.dart';
import 'package:odoo_client/app/data/pojo/music_skill.dart';
import 'package:odoo_client/app/data/services/user_service.dart';
part 'profile_edit_controller.g.dart';

class ProfileEditController = _ProfileEditControllerBase
    with _$ProfileEditController;

abstract class _ProfileEditControllerBase with Store {
  final UserService _userService;
  int _partnerId;

  _ProfileEditControllerBase(this._userService);

  @observable
  ObservableFuture _updateProfileRequest = ObservableFuture.value(null);

  ObservableFuture get updateProfileRequest => _updateProfileRequest;

  @observable
  PhotoWall photoWall;

  String _aboutYou;

  String get aboutYou => _aboutYou;

  List<int> _danceStyles;

  int _danceLevel;

  String _function;

  String get function => _function;

  @observable
  String _gender;

  String get gender => _gender;

  @observable
  DateTime _birthdate;
  DateTime get birthdate => _birthdate;

  set aboutYou(String value) => _aboutYou = value?.trim();
  set danceStyles(List<MusicGenre> items) => _danceStyles = items.map((e) => e.id).toList();
  set danceLevel(MusicSkill value) => _danceLevel = value.id;
  set function(String value) => _function = value?.trim();
  set gender(String value) => _gender = value?.trim();
  set partnerId(int value) => _partnerId = value;
  set birthdate(DateTime value) => _birthdate = value;

  @action
  void submit() {
    _updateProfileRequest = _userService
        .update(UpdateProfileDto(
          birthdate_date: birthdate,
          function: _function,
          gender: _gender,
          music_genre_ids: _danceStyles,
          music_skill_id: _danceLevel,
          partnerId: _partnerId,
          profile_description: _aboutYou,
        ))
        .asObservable();
  }
}

class PhotoWall{
 final MemoryImage principal;
 final MemoryImage primary;
 final MemoryImage secondary;

  PhotoWall(this.principal, this.primary, this.secondary);
}