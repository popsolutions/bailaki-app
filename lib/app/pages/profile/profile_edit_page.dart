import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:odoo_client/app/data/models/memory_image.dart';
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
  ReactionDisposer _updateProfileReaction;
  UserProfile _user;

  @override
  void initState() {
    _authenticationController = GetIt.I.get<AuthenticationController>();
    _profileEditController = GetIt.I.get<ProfileEditController>();
    _updateProfileReaction = reaction<FutureStatus>(
        (_) => _profileEditController.updateProfileRequest.status,
        _onUpdateUser);
    _initProfileData();
    super.initState();
  }

  final _newNameEC = TextEditingController();

  void _initProfileData() {
    _user = _authenticationController.currentUser;
    _profileEditController.images.addAll(_user.images);
    _profileEditController.partnerId = _user?.partnerId;
    _profileEditController.aboutYou = _user?.profile_description;
    _profileEditController.function = _user?.function;
    _profileEditController.gender = _user?.gender;
    _profileEditController.birthdate = _user.birthdate_date;
    _profileEditController.gender = _user.gender;
  }

  void _onUpdateUser(FutureStatus requestStatus) {
    final response = _profileEditController.updateProfileRequest;
    switch (requestStatus) {
      case FutureStatus.fulfilled:
        _onSuccess(response.value);
        break;
      default:
    }
  }

  void _onSuccess(FutureStatus requestStatus) {
    _authenticationController.authenticate(_user.copyWith(
      music_skill_id: _profileEditController.danceLevelId,
      music_genre_ids: _profileEditController.danceStyleIds,
      birthdate_date: _profileEditController.birthdate,
      images: List.of(_profileEditController.images),
      profile_description: _profileEditController.aboutYou,
      function: _profileEditController.function,
      gender: _profileEditController.gender,
    ));

    _updateProfileReaction();
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
              leading: Navigator.canPop(context)
                  ? BackButton(
                      color: Colors.black,
                    )
                  : null,
              centerTitle: true,
              title: Text(
                "Editar perfil",
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.grey[100],
            ),
            body: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      // Color.fromRGBO(0, 255, 253, 1),
                      // Color.fromRGBO(254, 0, 236, 1),
                      Colors.cyan,
                      Colors.pink,
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    Observer(builder: (_) {
                      return _buildPhotosContainer(
                        _profileEditController.images,
                      );
                    }),
                    Column(
                      children: [
                        Container(
                          color: Colors.transparent,
                          child: _buildTextFieldTile(
                            initialValue: _user.name,
                            title: "Seu nome",
                            onChanged: (e) {
                              _profileEditController.aboutYou = e;
                            },
                            counter: 120,
                            hasArrowIndicator: false,
                          ),
                          height: 200,
                        ),
                        const SizedBox(height: 10),
                        Container(
                          color: Colors.transparent,
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
                          height: 200,
                        ),
                        const SizedBox(height: 10),
                        _buildTile(
                            title: "Estilos de dança",
                            onTap: () async {
                              final items = await Navigator.of(context)
                                  .pushNamed("/musical_preferences");
                              _profileEditController.danceStyles = items;
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
                          height: 100,
                        ),
                        const SizedBox(height: 10),
                        Container(
                          child: GestureDetector(
                            onTap: () async {
                              final date = await showDatePicker(
                                context: context,
                                initialDate:
                                    DateTime(DateTime.now().year - 18, 1, 1),
                                firstDate: DateTime(1930, 1, 1),
                                lastDate: DateTime.now(),
                              );
                              if (date != null) {
                                _profileEditController.birthdate = date;
                              }
                            },
                            child: Observer(builder: (_) {
                              return _buildContainer(
                                  title: "Data de nascimento",
                                  subtitle: _profileEditController.birthdate !=
                                          null
                                      ? "${DateFormat('dd/MM/yyy').format(_profileEditController.birthdate)}"
                                      : "");
                            }),
                          ),
                          height: 70,
                        ),
                        const SizedBox(height: 10),
                        Container(
                          child: GestureDetector(
                            onTap: () async {
                              final result =
                                  await Navigator.of(context).pushNamed(
                                "/genree",
                                arguments: _profileEditController.gender,
                              );

                              if (result != null) {
                                _profileEditController.gender = result;
                              }
                            },
                            child: Observer(builder: (_) {
                              String subtitleString() {
                                switch (_profileEditController.gender) {
                                  case 'male':
                                    return 'Homem';
                                    break;
                                  case 'female':
                                    return 'Mulher';
                                    break;
                                  default:
                                    return '';
                                }
                              }

                              return _buildContainer(
                                title: "Gênero",
                                subtitle: subtitleString(),
                              );
                            }),
                          ),
                          height: 70,
                        ),
                        const SizedBox(height: 5),
                        Container(
                          width: MediaQuery.of(context).size.width * .8,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: const Color.fromRGBO(253, 0, 236, 1),
                            ),
                            onPressed: () async {
                              _authenticationController.logout();

                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                '/',
                                (route) => false,
                              );
                            },
                            child: Text('LogOut'),
                          ),
                        ),
                        const SizedBox(height: 15),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContainer({String title, String subtitle}) {
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
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: const Color.fromRGBO(227, 227, 224, 1),
          )
        ],
      ),
    ));
  }

  Widget _buildTextFieldTile({
    String title,
    String hintText,
    TextStyle hintTextStyle,
    String initialValue,
    TextEditingController controller,
    void Function(String value) onChanged,
    int counter,
    bool enabled = true,
    bool hasArrowIndicator = true,
  }) {
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
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: TextFormField(
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    initialValue: initialValue,
                    enabled: enabled,
                    controller: controller,
                    maxLines: null,
                    maxLength: 120,
                    onChanged: onChanged,
                    buildCounter: (
                      context, {
                      int currentLength,
                      bool isFocused,
                      int maxLength,
                    }) =>
                        Container(
                      width: 0,
                      height: 0,
                    ),
                    decoration: InputDecoration.collapsed(
                      hintText: hintText,
                      hintStyle: hintTextStyle,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
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
              color: Colors.white,
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
                color: Colors.white,
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

  Widget _buildPhotosContainer(List<Photo> images) {
    final newList = List<Photo>.from(images);

    final imageAmount = (images.length - 6);
    if (imageAmount < 0) {
      for (int i = 0; i < (imageAmount * -1); i++) {
        newList.add(Photo(id: null, bytes: null));
      }
    }

    return Container(
      padding: const EdgeInsets.only(bottom: 15, top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.cyan,
            Colors.pink,
          ],
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 3,
          ),
          itemCount: newList.length,
          itemBuilder: (_, index) {
            final item = newList[index];
            final isValid = item.bytes != null;
            return _buildRoundedImage(
              icon: isValid
                  ? Icon(Icons.close, color: Colors.white)
                  : Icon(Icons.add, color: Colors.white),
              onTap: () {
                if (isValid)
                  _profileEditController.removeImage(item);
                else
                  _profileEditController.addImage(context);
              },
              imageBytes: item.bytes,
            );
          },
        ),
      ),
    );
  }

  Widget _buildRoundedImage({
    Widget icon,
    VoidCallback onTap,
    List<int> imageBytes,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(color: Colors.transparent),
        Padding(
          padding: const EdgeInsets.all(7),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            child: Container(
              width: double.maxFinite,
              height: double.maxFinite,
              color: const Color.fromRGBO(201, 204, 201, 1),
              child: imageBytes != null
                  ? Image.memory(
                      imageBytes,
                      fit: BoxFit.cover,
                    )
                  : Container(),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: onTap,
            child: CircleAvatar(
              backgroundColor: const Color.fromRGBO(253, 0, 236, 1),
              radius: 13,
              child: icon,
            ),
          ),
        ),
      ],
    );
  }
}
