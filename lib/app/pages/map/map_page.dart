import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get_it/get_it.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:odoo_client/app/data/models/event_type.dart';
import 'package:odoo_client/app/data/services/ServiceNotifier.dart';
import 'package:odoo_client/app/pages/map/webview_event.dart';
import 'package:odoo_client/app/pages/profile/dance_style_page.dart';
import 'package:odoo_client/app/utility/global.dart';
import '../../data/models/event.dart';
import '../../data/services/odoo_api.dart';
import '../../../shared/controllers/authentication_controller.dart';
import 'package:collection/collection.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final user = GetIt.I.get<AuthenticationController>().currentUser;
  LatLng _center;

  Future<List<EventModel>> getEvents() async {
    List<EventModel> listEventModel = [];
    final odoo = GetIt.I.get<Odoo>();
    final response = await odoo.getApi('bailaki/events/');
    final List result = await response.getResponseApi();
    result.map((e) {
      Even_typeModel even_typeModel = globalServiceNotifier.listEven_typeModel.firstWhereOrNull((element) => element.id == e['event_type_id']);

      if ((even_typeModel != null) && (even_typeModel.selected))
        listEventModel.add(EventModel.fromJson(e));
    }).toList();

    return listEventModel;
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
      floatingActionButton: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 31),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: FloatingActionButton(
                backgroundColor: Colors.blue.withOpacity(0.6),
                onPressed: () async {
                  await showDialog(
                      context: context,
                      builder: (_) =>
                          AlertDialog(backgroundColor: Color.fromRGBO(245, 247, 250, 1), insetPadding: EdgeInsets.all(16), content: listEvenFilter(), actions: <Widget>[
                            FlatButton(
                              child: new Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ]));
                  setState(() {

                  });
                },
                child: Icon(Icons.search),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              backgroundColor: Colors.blue.withOpacity(0.6),
              onPressed: () async {
                await getCurrentLocation();
              },
              child: Icon(Icons.location_searching_sharp),
            ),
          ),
        ],
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

class listEvenFilter extends StatefulWidget {
  @override
  _listEvenFilterState createState() => _listEvenFilterState();
}

class _listEvenFilterState extends State<listEvenFilter> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              height: 120,
              padding: const EdgeInsets.only(
                  left: 12, right: 12, top: 20, bottom: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      "Selecione os estilos musicais que você gostaria de encontrar"),
                  Center(
                    child: Text(
                      "ESTILOS MUSICAIS",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Color.fromARGB(92, 92, 92, 1),
                      ),
                    ),
                  )
                ],
              )),
          Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
              child: Wrap(
                spacing: 10,
                children: globalServiceNotifier.listEven_typeModel.map((item) {
                  final isSelected = item.selected;
                  return MusicalPreferenceTile(
                    title: item.name,
                    isSelected: isSelected,
                    onPressed: () {
                      item.selected = !item.selected;
                      setState(() {

                      });
                    },
                  );
                }).toList(),
              )
          ),
        ],
      ),
    );
  }
}
