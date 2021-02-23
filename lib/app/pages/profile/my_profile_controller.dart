import 'package:mobx/mobx.dart';
import 'package:odoo_client/app/data/pojo/user_profile_dto.dart';
part 'my_profile_controller.g.dart';

class MyProfileController = _MyProfileControllerBase with _$MyProfileController;

abstract class _MyProfileControllerBase with Store {

  @observable
  ObservableFuture<UserProfileDto> _profile = ObservableFuture.value(null);

  ObservableFuture<UserProfileDto> get profile => _profile;

  @action
  void loadProfile(int userId, int userPartnerId) {
    
  }
}
