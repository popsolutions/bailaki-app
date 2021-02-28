import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:odoo_client/app/data/models/login_result.dart';
import 'package:odoo_client/app/data/pojo/user.dart';
import 'package:odoo_client/app/data/services/login_facade_impl.dart';
import 'package:odoo_client/app/pages/login/login_controller.dart';
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

  void _onLoginSuccess(LoginResult result) {
    final user = result.userProfile;
    _authenticationController.authenticate(user);
    _musicSkillsController.init(result.musicSkills,user.music_skill_id);
    _musicGenresController.init(result.musicGenres,user.music_genre_ids);
    Navigator.of(context).pushReplacementNamed('/home');
  }

  void _onLoginError() {
    showMessage("Authentication Failed", "Please Enter Valid Email or Password",
        context);
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
      keyboardType: TextInputType.emailAddress,
      labelText: "E-mail",
      onChanged: (e) => _loginController.email = e,
      validator: (e) =>
          e.contains('@') && e.contains('.') ? null : 'Insira um e-mail válido',
    );

    final password = CustomTextFormField(
      obscureText: true,
      labelText: "Password",
      onChanged: (e) => _loginController.password = e,
      validator: (e) => e.length >= 8 ? null : 'Insira uma entre válida',
    );

    final loginButton = PrimaryButton(
      title: 'Log In',
      onTap: _submit,
    );

    final signupButton = PrimaryButton(
      title: 'Signup',
      onTap: _loginController.signUp,
    );

    final loginWidget = Container(
      alignment: Alignment.bottomCenter,
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            // dbs,
            const SizedBox(height: 18.0),
            email,
            const SizedBox(height: 8.0),
            password,
            const SizedBox(height: 24.0),
            loginButton
          ],
        ),
      ),
    );

    final signupWidget = Container(
      alignment: Alignment.bottomCenter,
      child: Column(
        children: <Widget>[signupButton],
      ),
    );

    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(2, 255, 235, 1),
                Color.fromRGBO(128, 128, 236, 1),
                Color.fromRGBO(254, 0, 236, 1),
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          child: ListView(
            // padding: EdgeInsets.all(75.0),
            padding: EdgeInsets.fromLTRB(60, 70, 60, 0),
            children: <Widget>[
              Container(
                // margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      "./lib/app/assets/bailakil_logo.png",
                      width: 40,
                      height: 40,
                      fit: BoxFit.fill,
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Text(
                      "Bailaki",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          letterSpacing: -2.0),
                    )
                  ],
                ),
              ),
              //  getURL() == null ? checkURLWidget : SizedBox(height: 0.0),
              loginWidget,
              signupWidget,
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "By tapping Log in, you agree with our",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text.rich(TextSpan(
                    text: "Terms of service",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                    children: [
                      TextSpan(
                        text: " and ",
                        style: TextStyle(decoration: TextDecoration.none),
                      ),
                      TextSpan(
                        text: "Privacy Policy",
                      )
                    ],
                  )),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Trouble logging in?",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          "We don't post anything on Facebook",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white,
                      ),
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
    );
  }
}
