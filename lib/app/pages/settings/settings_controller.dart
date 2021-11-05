import 'package:get_it/get_it.dart';
import 'package:odoo_client/app/data/services/odoo_api.dart';

class SettingsController {
  final _odoo = GetIt.I.get<Odoo>();

  changeName(String newName) async {
    // await _odoo.write(model, ids, values); //TODO:
  }
}
