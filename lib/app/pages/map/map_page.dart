import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get_it/get_it.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:odoo_client/app/pages/map/webview_event.dart';
import '../../data/models/event.dart';
import '../../data/services/odoo_api.dart';
import '../../../shared/controllers/authentication_controller.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final user = GetIt.I.get<AuthenticationController>().currentUser;
  LatLng _center;

  Future<List<EventModel>> getEvents() async {
    final odoo = GetIt.I.get<Odoo>();
    final response = await odoo.getApi('bailaki/events/');
    final List result = await response.getResponseApi();
    return result.map((e) => EventModel.fromJson(e)).toList();
  }

  getCurrentLocation() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();

    setState(() {
      _center = LatLng(
        _locationData.latitude,
        _locationData.longitude,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.withOpacity(0.6),
        child: Icon(Icons.location_searching_sharp),
        onPressed: () async {
          await getCurrentLocation();
        },
      ),
      body: FutureBuilder<List<EventModel>>(
        future: getEvents(),
        builder: (context, snapshot) {
          final events = snapshot.data;

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return FlutterMap(
            options: MapOptions(
              interactiveFlags:
                  InteractiveFlag.pinchZoom | InteractiveFlag.drag,
              zoom: 13.0,
              center: _center,
            ),
            layers: [
              TileLayerOptions(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'],
              ),
              MarkerLayerOptions(
                markers: [
                  Marker(
                    point: _center,
                    builder: (_) => GestureDetector(
                      child: Icon(
                        Icons.person_pin_circle_outlined,
                        color: Colors.pink,
                        size: 50,
                      ),
                      onTap: () {},
                    ),
                  ),
                  for (EventModel marker in events)
                    Marker(
                      point: LatLng(
                        marker.partnerCurrentLatitude,
                        marker.partnerCurrentLongitude,
                      ),
                      builder: (_) => GestureDetector(
                        child: SvgPicture.asset('assets/local.svg'),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => WebView_eventPage(marker)));
                        },
                      ),
                    ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
