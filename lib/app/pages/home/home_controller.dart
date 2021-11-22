import 'package:location/location.dart';
import 'package:mobx/mobx.dart';
import 'package:odoo_client/app/data/models/update_profile_dto.dart';
import 'package:odoo_client/app/data/services/location_service.dart';
import 'package:odoo_client/app/data/services/user_service.dart';
import 'package:odoo_client/shared/components/custom_text_form_field.dart';
part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final LocationService _locationService;
  final UserService _userService;

  _HomeControllerBase(this._locationService, this._userService);

  @observable
  ObservableStream<LocationData> _currentLocation =
      Stream<LocationData>.empty().asObservable();

  ObservableStream<LocationData> get currentLocation => _currentLocation;

  @action
  void loadLocation() {
    _currentLocation = _locationService.getLocation().asObservable();
  }

  @action
  void updateLocation(LocationData locationData, int partnerId) {
    _userService.update(
      UpdateProfileDto(
        partnerId: partnerId,
        partnerCurrentLatitude: locationData.latitude,
        partnerCurrentLongitude: locationData.longitude,
      ),
    );
  }

  @observable
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;
  set currentIndex(int index) => _currentIndex = index;
}
