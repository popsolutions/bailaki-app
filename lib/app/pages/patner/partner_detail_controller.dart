import 'package:mobx/mobx.dart';
import 'package:odoo_client/app/data/pojo/partner_detail.dart';
import 'package:odoo_client/app/data/services/partner_service.dart';
part 'partner_detail_controller.g.dart';

class PartnerDetailController = _PartnerDetailControllerBase with _$PartnerDetailController;

abstract class _PartnerDetailControllerBase with Store {
   final PartnerService _partnerService;
  _PartnerDetailControllerBase(this._partnerService);

 
  @observable
  ObservableFuture<PartnerDetail> _partner = ObservableFuture.value(null);

  ObservableFuture<PartnerDetail> get partner => _partner;

  @action
  void loadPartner(int id) {
    _partner = _partnerService.finById(id).asObservable();
  } 
}