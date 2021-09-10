import 'package:location/location.dart';

abstract class LocationService {
  Stream<LocationData> getLocation();
  Future<bool> hasPermission();
  Future<bool> serviceEnabled();
}
