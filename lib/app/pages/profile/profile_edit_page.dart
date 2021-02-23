import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:odoo_client/app/data/services/login_facade_impl.dart';
import 'package:odoo_client/app/pages/profile/profile_edit_controller.dart';
import 'package:odoo_client/shared/components/container_tile.dart';
import 'package:odoo_client/shared/controllers/authentication_controller.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({Key key}) : super(key: key);
  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  AuthenticationController _authenticationController;
  ProfileEditController _profileEditController;
  UserProfile _user;
  final _formKey = GlobalKey<FormState>();

  void _initializeControllers() {
    _authenticationController = GetIt.I.get<AuthenticationController>();
    _profileEditController = GetIt.I.get<ProfileEditController>();
    _user = _authenticationController.currentUser;
    _profileEditController.partnerId = _user.partnerId;
  }

  @override
  void initState() {
    _initializeControllers();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _profileEditController.submit();
        return true;
      },
      child: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Color.fromRGBO(239, 242, 239, 1),
            appBar: AppBar(
              backgroundColor: Colors.black,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  _buildPhotoContainer(),
                  Column(
                    children: [
                      Container(
                        child: _buildTextFieldTile(
                          initialValue: _user.profile_description,
                          hintText: "Fale sobre você...",
                          onChanged: (e) {
                            _profileEditController.aboutYou = e;
                          },
                          title: "Sobre",
                          counter: 120,
                          hasArrowIndicator: false,
                        ),
                        height: 120,
                      ),
                      const SizedBox(height: 10),
                      _buildTile(
                          title: "Estilos de dança",
                          onTap: () async {
                            final result = await Navigator.of(context)
                                .pushNamed("/musical_preferences");
                            _profileEditController.danceStyles = result;
                          }),
                      const SizedBox(height: 10),
                      _buildTile(
                          title: "Nível de dança",
                          onTap: () async {
                            final result = await Navigator.of(context)
                                .pushNamed("/dance_level");
                            _profileEditController.danceLevel = result;
                          }),
                      const SizedBox(height: 10),
                      Container(
                        child: _buildTextFieldTile(
                          initialValue: _user.function,
                          hintText: "Diga a sua profissão...",
                          onChanged: (e) {
                            _profileEditController.function = e;
                          },
                          title: "Profissão",
                        ),
                        height: 70,
                      ),
                      const SizedBox(height: 10),
                      Container(
                        child: _buildTextFieldTile(
                          
                          hintText: "Diga seu grau de escolaridade",
                          onChanged: (e) {
                            _profileEditController.educationLevel = e;
                          },
                          title: "Escolaridade",
                        ),
                        height: 90,
                      ),
                      const SizedBox(height: 10),
                      Container(
                        child: _buildTextFieldTile(
                            hintText: "17/06/1992",
                            hintTextStyle:
                                TextStyle(color: Colors.blue, fontSize: 15),
                            onChanged: (e) {},
                            title: "Data de nascimento",
                            hasArrowIndicator: false),
                        height: 70,
                      ),
                      const SizedBox(height: 10),
                      Container(
                        child: GestureDetector(
                          onTap: () async {
                            final result = await Navigator.of(context)
                                .pushNamed("/genree");
                            _profileEditController.gender = result;
                          },
                          child: _buildTextFieldTile(
                            initialValue: _user.gender,
                            hintText: "Mulher",
                            hintTextStyle:
                                TextStyle(color: Colors.blue, fontSize: 15),
                            enabled: false,
                            title: "Gênero",
                          ),
                        ),
                        height: 70,
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFieldTile(
      {String title,
      String hintText,
      TextStyle hintTextStyle,
      String initialValue,
      TextEditingController controller,
      void Function(String value) onChanged,
      int counter,
      bool enabled = true,
      bool hasArrowIndicator = true}) {
    return ContainerTile(
        child: Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 1),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: const Color.fromRGBO(124, 127, 124, 1),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: TextFormField(
                    initialValue: initialValue,
                    enabled: enabled,
                    controller: controller,
                    maxLines: null,
                    maxLength: 120,
                    onChanged: onChanged,
                    maxLengthEnforced: true,
                    buildCounter: (context,
                            {int currentLength,
                            bool isFocused,
                            int maxLength}) =>
                        Container(
                      width: 0,
                      height: 0,
                    ),
                    decoration: InputDecoration.collapsed(
                        hintText: hintText,
                        hintStyle: hintTextStyle,
                        floatingLabelBehavior: FloatingLabelBehavior.never),
                  ),
                ),
                if (counter != null)
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "$counter",
                      style: const TextStyle(
                        color: const Color.fromRGBO(124, 127, 124, 1),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          if (hasArrowIndicator)
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: const Color.fromRGBO(227, 227, 224, 1),
            )
        ],
      ),
    ));
  }

  Widget _buildTile({String title, VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: ContainerTile(
          child: Padding(
        padding: const EdgeInsets.only(top: 4, bottom: 13),
        child: Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                color: const Color.fromRGBO(124, 127, 124, 1),
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Color.fromRGBO(227, 227, 224, 1),
            )
          ],
        ),
      )),
    );
  }

  Widget _buildPhotoContainer() {
    return Container(
      padding: const EdgeInsets.only(bottom: 15, top: 10),
      color: Color.fromRGBO(239, 242, 239, 1),
      child: Container(
        height: 230,
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                flex: 2,
                child: _buildRoundedImage(
                    icon: Icon(Icons.close, color: Colors.white),
                    onTap: () {},
                    imageUrl:
                        "https://yt3.ggpht.com/ytc/AAUvwnh1sZ8Y0mGlhOcdNor1ic3mn4NtTZsA6szvWSBKFw=s900-c-k-c0x00ffffff-no-rj")),
            Flexible(
              child: Column(
                children: [
                  Expanded(
                      child: _buildRoundedImage(
                          icon: Icon(Icons.close, color: Colors.white),
                          onTap: () {},
                          imageUrl:
                              "https://yt3.ggpht.com/ytc/AAUvwnh1sZ8Y0mGlhOcdNor1ic3mn4NtTZsA6szvWSBKFw=s900-c-k-c0x00ffffff-no-rj")),
                  Expanded(
                      child: _buildRoundedImage(
                          icon: Icon(Icons.close, color: Colors.white),
                          onTap: () {},
                          imageUrl:
                              "https://yt3.ggpht.com/ytc/AAUvwnh1sZ8Y0mGlhOcdNor1ic3mn4NtTZsA6szvWSBKFw=s900-c-k-c0x00ffffff-no-rj")),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRoundedImage({
    Widget icon,
    VoidCallback onTap,
    String imageUrl,
  }) {
    return Stack(
      overflow: Overflow.visible,
      children: [
        Container(color: Colors.transparent),
        Padding(
          padding: const EdgeInsets.all(7),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            child: Container(
                color: const Color.fromRGBO(201, 204, 201, 1),
                child: imageUrl != null
                    ? Image.network(
                        imageUrl,
                        fit: BoxFit.fill,
                      )
                    : null),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: onTap,
            child: CircleAvatar(
              backgroundColor: const Color.fromRGBO(253, 0, 236, 1),
              radius: 15,
              child: icon,
            ),
          ),
        ),
      ],
    );
  }
}
