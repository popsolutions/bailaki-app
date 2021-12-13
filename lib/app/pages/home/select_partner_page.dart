import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:odoo_client/app/pages/home/select_partner_controller.dart';
import 'package:odoo_client/shared/components/circular_inkwell.dart';
import 'package:odoo_client/shared/components/dialogs.dart';
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
    final user = _authenticationController.currentUser;
    _selectPartnerController.userPartnerId = user.partnerId;
    _selectPartnerController.loadPartners();

    super.initState();
  }

  Widget _buildCard(
      {Uint8List bytes,
      String name,
      int age,
      VoidCallback onTap,
      double distance}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 2,
            color: Color.fromRGBO(15, 18, 14, 1),
          ),
        ),
        margin: const EdgeInsets.all(15),
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (bytes != null)
              Image.memory(
                bytes,
                fit: BoxFit.cover,
              ),
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
                        "$name, $age - ${(distance / 1000)?.toStringAsFixed(2)} km",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Icon(Icons.person, color: Colors.white, size: 25)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _like() async {
    try {
      EasyLoading.show(maskType: EasyLoadingMaskType.black);
      await _selectPartnerController.like();
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      showMessage("Ops", "Tivemos problema ao efetuar o like: " + e.toString(), context);
    }
  }

  void _deslike() async {
    try {
      EasyLoading.show(maskType: EasyLoadingMaskType.black);
      _selectPartnerController.deslike();
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      showMessage("Ops", "Tivemos problema ao efetuar o deslike: " + e.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = _authenticationController.currentUser;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.cyan,
            Colors.pink,
          ],
        ),
      ),
      child: Observer(
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
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      "Não há nenhum parceiro na sua área, tente alterar as configurações",
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
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
                        bytes: current?.avatarPhoto?.bytes,
                        onTap: () => Navigator.of(context).pushNamed(
                            '/partner_detail',
                            arguments: current.id),
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
                                  color: Colors.blueAccent,
                                  child: const Icon(
                                    Icons.close,
                                    size: 45,
                                    color: Colors.white70,
                                  ),
                                  onTap: _deslike),
                              GestureDetector(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(40),
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    color: Color.fromRGBO(254, 0, 236, 1),
                                    height: 70,
                                    width: 70,
                                    child:
                                        Image.asset('assets/bailakil_logo.png'),
                                  ),
                                ),
                                onTap: _like,
                              ),
                              // CircularInkWell(
                              //   color: Color.fromRGBO(254, 0, 236, 1),
                              //   child: const Icon(
                              //     Icons.auto_awesome_sharp,
                              //     size: 45,
                              //     color: Colors.white,
                              //   ),
                              //   onTap: _like,
                              // ),
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
      ),
    );
  }
}
