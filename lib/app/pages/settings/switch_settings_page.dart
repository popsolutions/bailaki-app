import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:odoo_client/shared/components/circular_inkwell.dart';
import 'package:odoo_client/shared/controllers/authentication_controller.dart';

class SwitchSettingsPage extends StatefulWidget {
  const SwitchSettingsPage({Key key}) : super(key: key);

  @override
  _SwitchSettingsPageState createState() => _SwitchSettingsPageState();
}

class _SwitchSettingsPageState extends State<SwitchSettingsPage> {
  AuthenticationController _authenticationController;

  @override
  void initState() {
    _authenticationController = GetIt.I.get<AuthenticationController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = _authenticationController.currentUser;
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: const Color.fromRGBO(253, 255, 253, 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 70,
                        backgroundImage: NetworkImage(
                            "https://static.billboard.com/files/2021/01/rihanna-sept-2019-billboard-1548-1611156420-compressed.jpg"),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${user.name}",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color.fromRGBO(61, 64, 61, 1),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: const Color.fromRGBO(239, 242, 239, 1),
              padding: const EdgeInsets.only(top: 55),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildConfigTile(
                      icon: const Icon(
                        Icons.settings,
                        size: 30,
                        color: Colors.white,
                      ),
                      title: "Configurações",
                      onTap: () {
                        Navigator.of(context).pushNamed("/settings");
                      }),
                  _buildConfigTile(
                      icon: const Icon(
                        Icons.edit_outlined,
                        size: 30,
                        color: Colors.white,
                      ),
                      title: "Editar Perfil",
                      onTap: () {
                        Navigator.of(context).pushNamed("/profile_edit");
                      }),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildConfigTile({String title, Widget icon, VoidCallback onTap}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircularInkWell(
            child: icon,
            radius: 55,
            color: const Color.fromRGBO(186, 189, 185, 1),
            onTap: onTap),
        const SizedBox(
          height: 8,
        ),
        Text(
          title,
          style: TextStyle(
            color: Color.fromRGBO(195, 198, 195, 1),
          ),
        )
      ],
    );
  }
}
