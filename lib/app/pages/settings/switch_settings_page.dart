import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:odoo_client/app/data/services/login_facade_impl.dart';
import 'package:odoo_client/shared/components/circular_inkwell.dart';
import 'package:odoo_client/shared/controllers/authentication_controller.dart';

class SwitchSettingsPage extends StatefulWidget {
  const SwitchSettingsPage({Key key}) : super(key: key);

  @override
  _SwitchSettingsPageState createState() => _SwitchSettingsPageState();
}

class _SwitchSettingsPageState extends State<SwitchSettingsPage> {
  AuthenticationController _authenticationController;
  UserProfile _user;

  @override
  void initState() {
    _authenticationController = GetIt.I.get<AuthenticationController>();
    _user = _authenticationController.currentUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
      child: Column(
        children: [
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Observer(builder: (_) {
                    final user = _authenticationController.currentUser;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (_user.avatar != null)
                          CircleAvatar(
                            radius: 70,
                            backgroundImage: MemoryImage(
                              _authenticationController
                                  .currentUser.avatar.bytes,
                            ),
                          )
                        else
                          CircleAvatar(
                            backgroundColor: Color.fromRGBO(186, 189, 185, 1),
                            radius: 70,
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 70,
                            ),
                          ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "${user.name}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.edit,
                                color: Colors.pinkAccent,
                              ),
                              onPressed: () async {
                                await showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (_) {
                                    return AlertDialog(
                                      title: Text('Edite seu nome'),
                                      content: TextField(),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text('Cancelar'),
                                        ),
                                        TextButton(
                                          child: Text('Salvar'),
                                          onPressed: () {}, //TODO:
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          user?.function ?? '',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w300,
                            // color: Color.fromRGBO(61, 64, 61, 1),
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                      ],
                    );
                  })
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
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
                    },
                  ),
                  _buildConfigTile(
                    icon: const Icon(
                      Icons.edit_outlined,
                      size: 30,
                      color: Colors.white,
                    ),
                    title: "Editar Perfil",
                    onTap: () {
                      Navigator.of(context).pushNamed("/profile_edit");
                    },
                  ),
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
          onTap: onTap,
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          title,
          style: TextStyle(
            // color: Color.fromRGBO(195, 198, 195, 1),
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
