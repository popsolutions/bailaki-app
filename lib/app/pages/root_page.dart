import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:odoo_client/app/data/models/login_result.dart';
import 'package:odoo_client/app/data/services/login_facade_impl.dart';
import 'package:odoo_client/app/data/services/login_service.dart';
import 'package:odoo_client/app/data/services/login_service_impl.dart';
import 'package:odoo_client/app/data/services/music_genre_service.dart';
import 'package:odoo_client/app/data/services/music_genre_service_impl.dart';
import 'package:odoo_client/app/data/services/music_skill_service.dart';
import 'package:odoo_client/app/data/services/music_skill_service_impl.dart';
import 'package:odoo_client/app/data/services/odoo_api.dart';
import 'package:odoo_client/app/utility/global.dart';
import 'package:odoo_client/shared/components/dialogs.dart';
import 'package:odoo_client/shared/controllers/authentication_controller.dart';
import 'package:odoo_client/shared/controllers/music_genres_controller.dart';
import 'package:odoo_client/shared/controllers/music_skills_controller.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key key}) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  final _authenticationController = GetIt.I.get<AuthenticationController>();
  MusicGenresController _musicGenresController;
  MusicSkillsController _musicSkillsController;

  @override
  void initState() {
    _musicGenresController = GetIt.I.get<MusicGenresController>();
    _musicSkillsController = GetIt.I.get<MusicSkillsController>();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _authenticationController
          .initialAuthentication()
          .then(_onInitialAuthentication);
    });
    super.initState();
  }

  void _onInitialAuthentication(UserProfile currentUser) async {
    await readconfJson();

    final navigator = Navigator.of(context);
    if (currentUser == null) {
      navigator.pushReplacementNamed("/login");
    } else {
      try {
        final MusicGenreService _musicGenreService = MusicGenreServiceImpl(Odoo());
        final MusicSkillService _musicSkillService = MusicSkillServiceImpl(Odoo());

        final musicSkills = await _musicSkillService.findAll();
        final musicGenres = await _musicGenreService.findAll();

        LoginResult loginResult = LoginResult(currentUser, musicSkills, musicGenres);

        _musicSkillsController.init(loginResult.musicSkills, currentUser.music_skill_id);
        _musicGenresController.init(loginResult.musicGenres, currentUser.music_genre_ids);
        LoginServiceImpl loginServiceImpl = LoginServiceImpl(Odoo());
        await loginServiceImpl.tokenRegister(currentUser.uid, currentUser.name, currentUser.partnerId);
        navigator.pushReplacementNamed("/home");
      }catch(e){
        navigator.pushReplacementNamed("/login");
      }
    }
  }

  void readconfJson() async {
    try {
      await globalConfig.readconfJson();
      print('x');
    } catch(e) {
      await showMessage('Opss', 'Falha ao carregar parâmetros iniciais:\n${e.toString()}', context);
      exit(0);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
