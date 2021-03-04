import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:odoo_client/app/data/models/update_profile_dto.dart';
import 'package:odoo_client/app/data/services/user_service.dart';
part 'preferences_controller.g.dart';

class PreferencesController = _PreferencesControllerBase
    with _$PreferencesController;

abstract class _PreferencesControllerBase with Store {
  final UserService _userService;
  int partnerId;

  _PreferencesControllerBase(this._userService);

  @observable
  int maxDistance = 0;

  @observable
  RangeValues ageRange = RangeValues(18, 60);

  @observable
  bool interestingInMales = false;

  @observable
  bool interestingInFemales = false;

  @observable
  bool interestingInOthers = false;

  @observable
  bool receiveNewMatchesNotifications = false;

  @observable
  bool receiveChatNotifications = false;

  @observable
  ObservableFuture _updateRequest = ObservableFuture.value(null);

  ObservableFuture get updateRequest => _updateRequest;

  @action
  void submit() {
    _updateRequest = _userService
        .update(
          UpdateProfileDto(
            partnerId: partnerId,
            interestFemaleGender: interestingInFemales,
            interestMaleGender: interestingInMales,
            interestOtherGenres: interestingInOthers,
            refferedFriendMaxDistance: maxDistance,
            enableMatchNotification: receiveNewMatchesNotifications,
            enableMessageNotification: receiveChatNotifications,
            referredFriendMaxAge: ageRange.end.toInt(),
            referredFriendMinAge: ageRange.start.toInt(),
          ),
        )
        .asObservable();
  }
}
