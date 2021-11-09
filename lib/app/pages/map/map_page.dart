import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get_it/get_it.dart';
import 'package:latlong2/latlong.dart';
import 'package:odoo_client/shared/controllers/authentication_controller.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final user = GetIt.I.get<AuthenticationController>().currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
          zoom: 13.0,
          center: LatLng(user.position.latitude, user.position.longitude),
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayerOptions(
            markers: [
              Marker(
                point: LatLng(-7.1652, -34.8379), //TODO: REVER
                builder: (_) {
                  return FlutterLogo();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
