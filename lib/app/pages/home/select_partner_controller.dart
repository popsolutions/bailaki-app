import 'package:mobx/mobx.dart';
import 'package:odoo_client/app/data/models/deslike_dto.dart';
import 'package:odoo_client/app/data/models/like_dto.dart';
import 'package:odoo_client/app/data/pojo/partners.dart';
import 'package:odoo_client/app/data/services/partner_service.dart';
import 'package:odoo_client/app/data/services/relation_service.dart';
import 'package:odoo_client/app/data/services/send_like_facade.dart';
part 'select_partner_controller.g.dart';

class SelectPartnerController = _SelectPartnerControllerBase
    with _$SelectPartnerController;

abstract class _SelectPartnerControllerBase with Store {
  final SendLikeFacace _sendLikeFacace;
  final PartnerService _partnerService;
  final RelationService _relationService;

  int _userPartnerId;

  get userPartnerId => _userPartnerId;
  set userPartnerId(int userPartnerId) => _userPartnerId = userPartnerId;

  _SelectPartnerControllerBase(
      this._partnerService, this._relationService, this._sendLikeFacace);

  @observable
  ObservableFuture<List<Partner>> _partners = ObservableFuture.value(null);

  ObservableFuture<List<Partner>> get partners => _partners;

  @action
  void loadPartners() {
    _partners = _partnerService.finAll(_userPartnerId).asObservable();
  }

  @action
  void like() async {
    final items = _partners.value;
    await _sendLikeFacace.sendLike(LikeDto(_userPartnerId, items[0].id));
    items.removeAt(0);
    update(items);
  }

  @action
  void deslike() {
    final items = _partners.value;
    final desliked = items.removeAt(0);
    update(items);
    _relationService.sendDeslike(DeslikeDto(_userPartnerId, desliked.id));
  }

  @action
  void update(List<Partner> items) {
    _partners = ObservableFuture.value(items);
  }
}
