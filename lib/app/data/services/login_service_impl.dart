import 'dart:convert';

import 'package:odoo_client/app/data/pojo/user.dart';
import 'package:odoo_client/app/data/models/login_dto.dart';
import 'package:odoo_client/app/data/services/login_service.dart';
import 'package:odoo_client/app/data/services/odoo_api.dart';
import 'package:odoo_client/shared/authentication_exception.dart';

class LoginServiceImpl implements LoginService {
  final Odoo _odoo;

  LoginServiceImpl(this._odoo);

  @override
  Future<User> login(LoginDto loginDto) async {
    final path = _odoo.createPath("/web/session/authenticate");
    final params = {
      "db": "dev",
      "login": loginDto.username,
      "password": loginDto.password,
      "context": {}
    };
    final response =
        await _odoo.callDbRequest(path, _odoo.createPayload(params));

    final data = jsonDecode(response.body);
    if (data["error"] != null) {
      throw AuthenticationException("invalid username or password");
    }
    return User.fromJson(data);
  }

  /*
  // Authenticate user
  Future<http.Response> authenticate(
      String username, String password, String database) async {
    var url = createPath("/web/session/authenticate");
    var params = {
      "db":"bailaki-dev",
      //"db": database,
      "login": username,
      "password": password,
      "context": {}
    };
    final response = await callDbRequest(url, createPayload(params));
    return response;
  }
  */
}
