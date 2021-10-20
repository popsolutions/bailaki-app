import 'package:odoo_client/app/utility/global.dart';

class OdooResponse {
  var _result, _statusCode;

  OdooResponse(Map result, int statusCode) {
    _result = result;
    _statusCode = statusCode;

    if (getErrorMessage() == 'Session expired'){
      globalHomePage_logout();
      throw 'Sessão expirada, usuário encaminhado para tela de login';
    }
  }

  bool hasError() {
    return _result['error'] != null;
  }

  Map getError() {
    return _result['error'];
  }

  String getErrorMessage() {
    if (hasError()) {
      return _result['error']['data']['message'];
    }
    return null;
  }

  int getStatusCode() {
    return _statusCode;
  }

  dynamic getResult() {
    return _result['result'];
  }

  dynamic getRecords() {
    return getResult()['records'];
  }

  dynamic getResponse() {
    return _result['data']['response'];
  }
}
