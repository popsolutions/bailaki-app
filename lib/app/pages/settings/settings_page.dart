
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:odoo_client/shared/components/container_tile.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key key}) : super(key: key);
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  double distance = 0.0;
  var rangeValues = RangeValues(18, 18);

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
    return Scaffold(
    appBar: AppBar(
        backgroundColor: Colors.black
      ),
      backgroundColor: Color.fromRGBO(239, 242, 239, 1),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderTitle(title: "Descoberta"),
              const SizedBox(height: 10),
              _buildRangeTile(
                leading: "Distância máxima",
                trailing: "100 km",
                maxText: "100",
                minText: "0",
                child: CupertinoSlider(
                  divisions: 100,
                  thumbColor: const Color.fromRGBO(254, 0, 236, 1),
                  value: distance,
                  min: 0,
                  max: 100,
                  onChanged: (e) {
                    setState(() {
                      distance = e;
                    });
                  },
                ),
              ),
              const SizedBox(height: 10),
              _buildRangeTile(
                leading: "Faixa etária",
                trailing:
                    "${rangeValues.start.toInt()} - ${rangeValues.end.toInt()}",
                maxText: "55+",
                minText: "18",
                child: SliderTheme(
                  data: Theme.of(context).sliderTheme.copyWith(
                        thumbColor: const Color.fromRGBO(254, 0, 236, 1),
                        trackHeight: 0.1,
                        thumbShape:
                            RoundSliderThumbShape(enabledThumbRadius: 40.0),
                        overlayShape:
                            RoundSliderOverlayShape(overlayRadius: 15.0),
                      ),
                  child: RangeSlider(
                    divisions: 55,
                    labels: RangeLabels("${rangeValues.start.toInt()}",
                        "${rangeValues.end.toInt()}"),
                    values: rangeValues,
                    min: 18,
                    max: 55,
                    onChanged: (e) {
                      setState(() {
                        rangeValues = e;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 25),
              _buildHeaderTitle(title: "Procurando por"),
              const SizedBox(height: 10),
              _buildSwitchTile(
                title: "Homens",
                state: false,
                onChanged: (e) {},
              ),
              const SizedBox(height: 10),
              _buildSwitchTile(
                title: "Mulheres",
                state: false,
                onChanged: (e) {},
              ),
              const SizedBox(height: 10),
              _buildSwitchTile(
                title: "Outros",
                state: false,
                onChanged: (e) {},
              ),
              const SizedBox(height: 25),
              _buildHeaderTitle(title: "Notificações"),
              const SizedBox(height: 10),
              _buildSwitchTile(
                title: "Novos matches",
                state: false,
                onChanged: (e) {},
              ),
              const SizedBox(height: 10),
              _buildSwitchTile(
                title: "Mensagens",
                state: false,
                onChanged: (e) {},
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
