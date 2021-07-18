import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:odoo_client/app/pages/settings/preferences_controller.dart';
import 'package:odoo_client/shared/components/container_tile.dart';
import 'package:odoo_client/shared/controllers/authentication_controller.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key key}) : super(key: key);
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  PreferencesController _preferencesController;
  AuthenticationController _authenticationController;
  ReactionDisposer _updateSettingsReaction;

  @override
  void initState() {
    super.initState();
    _authenticationController = GetIt.I.get<AuthenticationController>();
    _preferencesController = GetIt.I.get<PreferencesController>();
    _preferencesController.partnerId =
        _authenticationController.currentUser?.partnerId;
    _initPreferencesData();
    _updateSettingsReaction = reaction<FutureStatus>(
        (_) => _preferencesController.updateRequest.status, _onUpdateRequest);
  }

  void _initPreferencesData() {
    final userProfile = _authenticationController.currentUser;
    _preferencesController.interestingInFemales = userProfile?.interestFemales;
    _preferencesController.interestingInMales = userProfile?.interestMales;
    _preferencesController.interestingInOthers = userProfile.interestOtherGenres;
    _preferencesController.maxDistance = userProfile?.refferedMaxFriendDistance;
    _preferencesController.receiveChatNotifications =
        userProfile?.enableMessageNotification;
    _preferencesController.receiveNewMatchesNotifications =
        userProfile?.enableMatchNotification;

    if (userProfile?.referredFriendMinAge != null &&
        userProfile?.referredFriendMaxAge != null) {
      _preferencesController.ageRange = RangeValues(
          userProfile?.referredFriendMinAge?.toDouble(),
          userProfile?.referredFriendMaxAge?.toDouble());
    }
  }

  void _onUpdateRequest(FutureStatus requestStatus) {
    final response = _preferencesController.updateRequest;
    switch (requestStatus) {
      case FutureStatus.fulfilled:
        _onSuccess(response.value);
        break;
      default:
    }
  }

  void _onSuccess(value) {
    final currentUser = _authenticationController.currentUser;
    _authenticationController.authenticate(currentUser.copyWith(
        interestFemales: _preferencesController.interestingInFemales,
        interestMales: _preferencesController.interestingInMales,
        interestOtherGenres: _preferencesController.interestingInOthers,
        refferedMaxFriendDistance: _preferencesController.maxDistance,
        referredFriendMaxAge: _preferencesController.ageRange.end.toInt(),
        referredFriendMinAge: _preferencesController.ageRange.start.toInt(),
        enableMatchNotification:
            _preferencesController.receiveChatNotifications,
        enableMessageNotification:
            _preferencesController.receiveNewMatchesNotifications));
    _updateSettingsReaction();
  }

  Widget _buildSwitchTile({
    String title,
    bool state,
    void Function(bool value) onChanged,
  }) {
    return ContainerTile(
        child: Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Color.fromRGBO(156, 158, 155, 1),
          ),
        ),
        Spacer(),
        CupertinoSwitch(
          value: state,
          onChanged: onChanged,
          activeColor: Color.fromRGBO(254, 0, 236, 1),
        ),
      ],
    ));
  }

  Widget _buildHeaderTitle({String title}) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          color: Color.fromRGBO(254, 0, 236, 1),
        ),
      ),
    );
  }

  Widget _buildRangeTile(
      {Widget child,
      String leading,
      String trailing,
      String minText,
      String maxText}) {
    return ContainerTile(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                leading,
                style: const TextStyle(
                  color: Color.fromRGBO(156, 158, 155, 1),
                ),
              ),
              Text(
                trailing,
                style: const TextStyle(
                  color: Color.fromRGBO(156, 158, 155, 1),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Container(
            child: Row(
              children: [
                Text(
                  minText,
                  style: const TextStyle(
                    color: Color.fromRGBO(37, 40, 36, 1),
                  ),
                ),
                Expanded(child: child),
                Text(
                  maxText,
                  style: const TextStyle(
                    color: Color.fromRGBO(37, 40, 36, 1),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _preferencesController.submit();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
            leading: Navigator.canPop(context)
                ? BackButton(
                    color: Colors.black,
                  )
                : null,
            centerTitle: true,
            title: Text(
              "Configurações",
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.grey[100]),
        backgroundColor: Colors.grey[100],
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeaderTitle(title: "Descoberta"),
                const SizedBox(height: 10),
                Observer(
                  builder: (_) => _buildRangeTile(
                    leading: "Distância máxima",
                    trailing: "${_preferencesController.maxDistance} km",
                    maxText: "100",
                    minText: "0",
                    child: CupertinoSlider(
                      divisions: 100,
                      thumbColor: Colors.red,
                      value: _preferencesController.maxDistance.toDouble(),
                      min: 0,
                      max: 100,
                      onChanged: (e) =>
                          _preferencesController.maxDistance = e.truncate(),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Observer(builder: (_) {
                  final rangeValues = _preferencesController.ageRange;
                  return _buildRangeTile(
                    leading: "Faixa etária",
                    trailing:
                        "${rangeValues.start.toInt()} - ${rangeValues.end.toInt()}",
                    maxText: "55+",
                    minText: "18",
                    child: SliderTheme(
                      data: Theme.of(context).sliderTheme.copyWith(
                            thumbColor: Colors.red,
                            trackHeight: 0.1,
                            thumbShape:
                                RoundSliderThumbShape(enabledThumbRadius: 40.0),
                            overlayShape:
                                RoundSliderOverlayShape(overlayRadius: 15.0),
                          ),
                      child: RangeSlider(
                        divisions: 33,
                        labels: RangeLabels("${rangeValues.start.toInt()}",
                            "${rangeValues.end.toInt()}"),
                        values: rangeValues,
                        min: 18,
                        max: 100,
                        onChanged: (e) => _preferencesController.ageRange = e,
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 25),
                _buildHeaderTitle(title: "Procurando por"),
                const SizedBox(height: 10),
                Observer(builder: (_) {
                  return _buildSwitchTile(
                    title: "Homens",
                    state: _preferencesController.interestingInMales,
                    onChanged: (e) =>
                        _preferencesController.interestingInMales = e,
                  );
                }),
                const SizedBox(height: 10),
                Observer(builder: (_) {
                  return _buildSwitchTile(
                    title: "Mulheres",
                    state: _preferencesController.interestingInFemales,
                    onChanged: (e) =>
                        _preferencesController.interestingInFemales = e,
                  );
                }),
                const SizedBox(height: 10),
                Observer(builder: (_) {
                  return _buildSwitchTile(
                    title: "Outros",
                    state: _preferencesController.interestingInOthers,
                    onChanged: (e) =>
                        _preferencesController.interestingInOthers = e,
                  );
                }),
                const SizedBox(height: 25),
                _buildHeaderTitle(title: "Notificações"),
                const SizedBox(height: 10),
                Observer(builder: (_) {
                  return _buildSwitchTile(
                    title: "Novos matches",
                    state:
                        _preferencesController.receiveNewMatchesNotifications,
                    onChanged: (e) => _preferencesController
                        .receiveNewMatchesNotifications = e,
                  );
                }),
                const SizedBox(height: 10),
                Observer(builder: (_) {
                  return _buildSwitchTile(
                    title: "Mensagens",
                    state: _preferencesController.receiveChatNotifications,
                    onChanged: (e) =>
                        _preferencesController.receiveChatNotifications = e,
                  );
                }),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
