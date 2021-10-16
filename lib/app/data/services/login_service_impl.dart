import 'dart:convert';

import 'package:odoo_client/app/data/pojo/user.dart';
import 'package:odoo_client/app/data/models/login_dto.dart';
import 'package:odoo_client/app/data/services/login_service.dart';
import 'package:odoo_client/app/data/services/odoo_api.dart';
import 'package:odoo_client/app/utility/global.dart';
import 'package:odoo_client/shared/authentication_exception.dart';
import 'package:get_version/get_version.dart';

String firebaseToken = '';

class LoginServiceImpl implements LoginService {
  final Odoo _odoo;

  LoginServiceImpl(this._odoo);

  @override
  Future<User> login(LoginDto loginDto) async {
    final path = _odoo.createPath("/web/session/authenticate");
    final params = {
      "db": globalConfig.dbName,
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

    //t.todo - Verificar com Rully onde é melhor colocar a parte de informar o token para o odoo


    String projectAppID = await GetVersion.appID;

    String appName = await GetVersion.appName;
    String platformVersion = await GetVersion.platformVersion;
    String projectCode = await GetVersion.projectCode;
    String projectVersion = await GetVersion.projectVersion;

    User user = User.fromJson(data);

    await tokenRegister(user.result.uid, user.result.username, user.result.partnerId);

    return user;
  }

  Future<User> tokenRegister(int userId, String userName, int partnerId) async {
    String projectAppID = await GetVersion.appID;
    String name = await GetVersion.platformVersion;
    name = name + ' - ' + userId.toString() + ' - ' + userName;

    final res = await _odoo.create('hermes.token', {
      'name':name,
      'partner_id': partnerId,
      'app_id': projectAppID,
      'token': firebaseToken
    });
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
