import 'package:odoo_client/app/data/models/event_type.dart';
import 'package:odoo_client/app/data/services/odoo_api.dart';

class ServiceNotifier {
  List<Even_typeModel> listEven_typeModel = [];
  Odoo odoo = Odoo();

  void init() {
    listEven_typeModel_Load();
  }

  listEven_typeModel_Load() async {
    final response = await odoo.searchRead('event.type', [], [
      "id",
      "name",
    ]);

    listEven_typeModel.clear();

    response.getRecords().map<Even_typeModel>((e) {
      listEven_typeModel.add(Even_typeModel.fromMap(e));
    }).toList();
  }
}
