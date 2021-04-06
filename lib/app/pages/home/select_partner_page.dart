import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:odoo_client/app/pages/home/select_partner_controller.dart';
import 'package:odoo_client/shared/components/circular_inkwell.dart';
import 'package:odoo_client/shared/controllers/authentication_controller.dart';
import 'package:odoo_client/shared/utils/distance_between.dart';

class SelectPartnerPage extends StatefulWidget {
  const SelectPartnerPage({Key key}) : super(key: key);
  @override
  _SelectPartnerPageState createState() => _SelectPartnerPageState();
}

class _SelectPartnerPageState extends State<SelectPartnerPage> {
  AuthenticationController _authenticationController;
  SelectPartnerController _selectPartnerController;

  @override
  void initState() {
    _authenticationController = GetIt.I.get<AuthenticationController>();
    _selectPartnerController = GetIt.I.get<SelectPartnerController>();
    _selectPartnerController.userPartnerId =
        _authenticationController.currentUser?.partnerId;
    _selectPartnerController.loadPartners();
    _selectPartnerController.loadLocation();
    super.initState();
  }

  Widget _buildCard(
      {String url, String name, int age, VoidCallback onTap, double distance}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: Color.fromRGBO(15, 18, 14, 1),
          ),
        ),
        margin: const EdgeInsets.all(15),
        child: Stack(
          fit: StackFit.expand,
          children: [
            /*
            Image.network(
              url,
              fit: BoxFit.fill,
              headers: {"Cookie": "b519d846e1a07885edd07d97298c3d892fc7c8f0 "},
            ),
            */
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Color.fromRGBO(15, 18, 14, 1),
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                  right: 10,
                  left: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        "$name, $age - ${distance?.toStringAsFixed(2)} km",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Icon(Icons.zoom_out_outlined, color: Colors.white, size: 25)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _like() {
    _selectPartnerController.like();
  }

  void _deslike() {
    _selectPartnerController.deslike();
  }

  @override
  Widget build(BuildContext context) {
    final user = _authenticationController.currentUser;

    return Observer(
      builder: (_) {
        final response = _selectPartnerController.partners;
        final data = response.value;
        switch (response.status) {
          case FutureStatus.rejected:
            return const Center(
              child: Text('Is empty'),
            );
          case FutureStatus.pending:
            return const Center(
              child: CircularProgressIndicator(),
            );
          default:
            if (data.isEmpty) {
              return const Center(
                child: Text(
                    "Não tem nenhum parceiro na sua área, tente alterar as configurações",
                    textAlign: TextAlign.center),
              );
            } else {
              final current = data.first;
              final distance = distanceBetween(
                  user.position.latitude,
                  user.position.longitude,
                  current.position.latitude,
                  current.position.longitude);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 2,
                    child: _buildCard(
                      distance: distance,
                      name: current.name,
                      age: 19,
                      url:
                          "https://bailaki.com.br/web/image?model=res.partner&field=image&b519d846e1a07885edd07d97298c3d892fc7c8f0&id=${current.id}",
                      onTap: () => Navigator.of(context)
                          .pushNamed('/partner_detail', arguments: current.id),
                    ),
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircularInkWell(
                                color: Color.fromRGBO(0, 255, 253, 1),
                                child: const Icon(
                                  Icons.close,
                                  size: 45,
                                  color: Colors.white,
                                ),
                                onTap: _deslike),
                            CircularInkWell(
                                radius: 40,
                                color: Color.fromRGBO(202, 205, 202, 1),
                                child: Icon(Icons.hourglass_empty_sharp),
                                onTap: () {}),
                            CircularInkWell(
                                color: Color.fromRGBO(254, 0, 236, 1),
                                child: const Icon(
                                  Icons.search,
                                  size: 45,
                                  color: Colors.white,
                                ),
                                onTap: _like),
                          ],
                        ),
                      ],
                    ),
                  ))
                ],
              );
            }
        }
      },
    );
  }
}
