import 'package:get_it/get_it.dart';
import 'package:odoo_client/app/data/services/odoo_api.dart';
import 'package:odoo_client/app/data/services/utils.dart';
import 'package:odoo_client/app/utility/global.dart';

class Config_ParameterService {
  //Esta classe pega os parâmetros configurados no Odoo em Technical/System Parameters

  final _prefixKey = 'MobileBailakiParams.';

  Future<List<Config_ParameterModel>> getMobileVariablesModel() async {
    final odoo = GetIt.I.get<Odoo>();
    final response = await odoo.getApi('bailaki/ir_config_parameters');
    final List json = response.getResponseApi();
    final listConfig_ParameterModel =
        json.map((e) => Config_ParameterModel.fromJson(e)).toList();
    return listConfig_ParameterModel;
  }

  int convertStringToInt(String value) => Utils.convertStringToInt(value);

  Future<void> setGlobalConfig(String userId) async {
    Utils.Log('Config_ParameterService.setGlobalConfig', 'Start');
    List<Config_ParameterModel> listConfig_ParameterModel;
    Config_ParameterModel currentConfig_ParameterModel;

    try {
      listConfig_ParameterModel = await getMobileVariablesModel();
    } catch (e) {
      Utils.Log(
          'Config_ParameterService.setGlobalConfig', 'catch: ${e.toString()}');
      return;
    }

    bool findVar(String x_variable_name) {
      Utils.Log('Config_ParameterService.setGlobalConfig',
          'findVar: $x_variable_name');

      currentConfig_ParameterModel = listConfig_ParameterModel.firstWhere(
          (element) =>
              element.key.toUpperCase() ==
              (_prefixKey + x_variable_name).toUpperCase(),
          orElse: () => null);

      if (currentConfig_ParameterModel == null)
        Utils.Log(
            'Config_ParameterService.setGlobalConfig', 'findVar not found');
      else
        Utils.Log('Config_ParameterService.setGlobalConfig',
            'findVar Sucess with value : "${currentConfig_ParameterModel.value}"');

      return currentConfig_ParameterModel != null;
    }

    if (findVar('hoursDiffServer'))
      globalConfig.hoursDiffServer =
          convertStringToInt(currentConfig_ParameterModel.value);

    String activeRegisterLogApiUser = 'EnableRegisterLogApi_$userId';

    globalConfig.activeRegisterLogApiUser = findVar(activeRegisterLogApiUser);
    if (globalConfig.activeRegisterLogApiUser) {
      try {
        globalConfig.activeRegisterLogApiUser_QtdeChar =
            convertStringToInt(currentConfig_ParameterModel.value);
      } catch (e) {
        globalConfig.activeRegisterLogApiUser_QtdeChar = 0;
      }
    }
    print('x');
  }
}

class Config_ParameterModel {
  int id;
  String key;
  String value;

  Config_ParameterModel(this.id, this.key, this.value);

  Config_ParameterModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    value = json['value'];
  }
}
