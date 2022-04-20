import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:odoo_client/app/data/models/login_result.dart';
import 'package:odoo_client/app/pages/login/login_controller.dart';
import 'package:odoo_client/app/utility/global.dart';
import 'package:odoo_client/shared/components/custom_text_form_field.dart';
import 'package:odoo_client/shared/components/primary_button.dart';
import 'package:odoo_client/shared/components/dialogs.dart';
import 'package:odoo_client/shared/controllers/authentication_controller.dart';
import 'package:odoo_client/shared/controllers/music_genres_controller.dart';
import 'package:odoo_client/shared/controllers/music_skills_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  AuthenticationController _authenticationController;
  MusicGenresController _musicGenresController;
  MusicSkillsController _musicSkillsController;
  LoginController _loginController;

  ReactionDisposer _loginReaction;

  @override
  void initState() {
    _authenticationController = GetIt.I.get<AuthenticationController>();
    _musicGenresController = GetIt.I.get<MusicGenresController>();
    _musicSkillsController = GetIt.I.get<MusicSkillsController>();
    _loginController = GetIt.I.get<LoginController>();

    _loginReaction =
        reaction((_) => _loginController.loginRequest.status, _onLoginRequest);

    _loginController.email = globalConfig.userOdoo;
    _loginController.password = globalConfig.pass;
    super.initState();
  }

  void _onLoginRequest(FutureStatus status) {
    final response = _loginController.loginRequest.value;
    switch (status) {
      case FutureStatus.fulfilled:
        _onLoginSuccess(response);
        break;
      case FutureStatus.rejected:
        _onLoginError();
        break;
      default:
    }

    if (_loginController.isLoading) {
      EasyLoading.show();
    } else {
      EasyLoading.dismiss();
    }
  }

  void _onLoginSuccess(LoginResult result) async {
    final user = result.userProfile;
    _authenticationController.authenticate(user);
    _musicSkillsController.init(result.musicSkills, user.music_skill_id);
    _musicGenresController.init(result.musicGenres, user.music_genre_ids);
    await globalConfig_ParameterService
        .setGlobalConfig(_authenticationController.currentUser.uid.toString());

    globalServiceNotifier.init();

    Navigator.of(context).pushReplacementNamed('/home');
  }

  void _onLoginError() {
    showMessage(
      "Authentication Failed",
      "Please Enter Valid Email or Password",
      context,
    );
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState.validate()) {
      _loginController.submit();
    }
  }

  @override
  void dispose() {
    _loginReaction();
    super.dispose();
  }

  //'https://bailaki.com.br'

  @override
  Widget build(BuildContext context) {
    final email = CustomTextFormField(
      initialValue: globalConfig.userOdoo,
      keyboardType: TextInputType.emailAddress,
      labelText: "E-mail",
      onChanged: (e) => _loginController.email = e,
      validator: (e) =>
          e.contains('@') && e.contains('.') ? null : 'Insira um e-mail válido',
    );

    final password = CustomTextFormField(
      initialValue: globalConfig.pass,
      obscureText: true,
      labelText: "Password",
      onChanged: (e) => _loginController.password = e,
      validator: (e) => e.length >= 1 ? null : 'Insira uma entre válida',
    );

    final loginButton = PrimaryButton(
      title: 'Entrar',
      onTap: _submit,
      color: Colors.grey[100],
      titleStyle: TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
    );

    final signupButton = PrimaryButton(
      title: 'Cadastrar',
      // onTap: _loginController.signUp,
      onTap: () {
        Navigator.pushNamed(
          context,
          '/register',
        );
      },
      color: Colors.grey[100],
      titleStyle: TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
    );

    final loginWidget = Container(
      alignment: Alignment.bottomCenter,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 16.0),
            email,
            const SizedBox(height: 16.0),
            password,
            loginButton
          ],
        ),
      ),
    );

    final signupWidget = Container(
      alignment: Alignment.center,
      child: signupButton,
    );

    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Container(
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
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(60, 70, 60, 0),
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    width: 250,
                    height: 80,
                    child: Image.asset(
                      "assets/logo.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                  //  getURL() == null ? checkURLWidget : SizedBox(height: 0.0),
                  loginWidget,
                  signupWidget,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/ForgotoPasswordPage',
                          );
                        },
                        child: Text(
                          "Esqueci minha senha",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Ao tocar em Login, você concorda com nossos",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 4),
                      Text.rich(TextSpan(
                        text: "Termos de serviço",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                        children: [
                          TextSpan(
                            text: " e ",
                            style: TextStyle(
                              color: Colors.black,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          TextSpan(
                            text: "Política de Privacidade",
                            style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.underline,
                            ),
                          )
                        ],
                      )),
                      SizedBox(height: 16),
                      Text(
                        "Problemas para fazer login?",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              "Nós não postamos nada no Facebook",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          // SizedBox(
                          //   width: 3,
                          // ),
                          // Icon(
                          //   Icons.keyboard_arrow_down,
                          //   color: Colors.black,
                          // ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
