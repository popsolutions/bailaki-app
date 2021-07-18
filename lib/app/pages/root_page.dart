import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:odoo_client/app/data/services/login_facade_impl.dart';
import 'package:odoo_client/shared/controllers/authentication_controller.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key key}) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  final _authenticationController = GetIt.I.get<AuthenticationController>();
  ReactionDisposer _initialAuthenticationReaction;

  @override
  void initState() {
    _initialAuthenticationReaction = reaction(
        (_) => _authenticationController.currentUser, _onInitialAuthentication);
    _authenticationController.initialAuthentication();
    super.initState();
  }

  void _onInitialAuthentication(UserProfile currentUser) {
    final navigator = Navigator.of(context);
    if (currentUser == null) {
      navigator.pushReplacementNamed("/login");
    } else {
      navigator.pushReplacementNamed("/home");
    }
  }

  @override
  void dispose() {
    _initialAuthenticationReaction();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
