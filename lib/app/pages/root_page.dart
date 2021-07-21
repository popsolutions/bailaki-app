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

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _authenticationController
          .initialAuthentication()
          .then(_onInitialAuthentication);
    });
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
