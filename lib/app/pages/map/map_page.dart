import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get_it/get_it.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
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
    List<EventModel> events = [];

    result.map((e) {
      log('$e');
      events.add(EventModel.fromJson(e));
    }).toList();

    return events;
    // return result.map((e) => EventModel.fromJson(e)).toList();
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
      _center = LatLng(_locationData.latitude, _locationData.longitude);
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
                      child: FlutterLogo(),
                      onTap: () {},
                    ),
                  ),

                  // for (var marker in events)
                  //   Marker(
                  //     point: LatLng(
                  //       marker.partnerCurrentLatitude,
                  //       marker.partnerCurrentLongitude,
                  //     ),
                  //     builder: (_) => GestureDetector(
                  //       child: FlutterLogo(),
                  //       onTap: () {},
                  //     ),
                  //   ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
