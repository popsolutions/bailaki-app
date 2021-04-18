import 'package:location/location.dart';
import 'package:odoo_client/app/data/services/location_service.dart';

class LocationServiceImpl implements LocationService {
  final Location _location;

  LocationServiceImpl(this._location);

  @override
  Stream<LocationData> getLocation() async* {
    final isGranted = await hasPermission();
    if (!isGranted) await requestService();
    yield* _location.onLocationChanged;
  }

  @override
  Future<bool> hasPermission() async {
    final permission = await _location.hasPermission();
    final hasPermission = permission != PermissionStatus.granted ||
        permission != PermissionStatus.grantedLimited;
    return hasPermission;
  }

  @override
  Future<bool> serviceEnabled() {
    return _location.serviceEnabled();
  }

  Future<bool> requestService() {
    return _location.requestService();
  }
}
