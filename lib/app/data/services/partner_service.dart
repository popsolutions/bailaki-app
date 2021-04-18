import 'package:odoo_client/app/data/pojo/partner_detail.dart';
import 'package:odoo_client/app/data/pojo/partners.dart';

abstract class PartnerService {
  Future<List<Partner>> finAll(List<int> friendIds);
  Future<PartnerDetail> finById(int id);
}
