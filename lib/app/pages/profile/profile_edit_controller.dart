import 'package:mobx/mobx.dart';
import 'package:odoo_client/app/data/models/update_profile_dto.dart';
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

  String _aboutYou;

  List<int> _danceStyles;

  int _danceLevel;

  String _function;

  String _educationalLevel;

  @observable
  String _gender;

  String get gender => _gender;

  set aboutYou(String value) => _aboutYou = value.trim();
  set danceStyles(List<int> items) => _danceStyles = items;
  set danceLevel(int value) => _danceLevel = value;
  set function(String value) => _function = value.trim();
  set educationLevel(String value) => _educationalLevel = value.trim();
  set gender(String value) => _gender = value.trim();
  set partnerId(int value) => _partnerId = value;

  @action
  void submit() {
    _updateProfileRequest = _userService
        .update(UpdateProfileDto(
          birthdate_date: null,
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
