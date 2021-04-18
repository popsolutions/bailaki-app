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
  List<int> _referredFriendIds;

  _SelectPartnerControllerBase(
      this._partnerService, this._relationService, this._sendLikeFacace);

  @observable
  ObservableFuture<List<Partner>> _partners = ObservableFuture.value(null);

  ObservableFuture<List<Partner>> get partners => _partners;

  set userPartnerId(int userPartnerId) => _userPartnerId = userPartnerId;
  set referredFriendIds(List<int> friendIds) => _referredFriendIds = friendIds;

  @action
  void loadPartners() {
    _partners = _partnerService.finAll(_referredFriendIds).asObservable();
  }

  @action
  void like() {
    final items = _partners.value;
    final liked = items.removeAt(0);
    update(items);
    _sendLikeFacace.sendLike(LikeDto(_userPartnerId, liked.id));
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
