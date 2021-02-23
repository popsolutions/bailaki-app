import 'package:mobx/mobx.dart';
import 'package:odoo_client/app/data/models/like_dto.dart';
import 'package:odoo_client/app/data/pojo/partners.dart';
import 'package:odoo_client/app/data/services/partner_service.dart';
import 'package:odoo_client/app/data/services/relation_service.dart';
part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final PartnerService _partnerService;
  final RelationService _relationService;
  int _userPartnerId;

  _HomeControllerBase(this._partnerService, this._relationService);

  @observable
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  @observable
  ObservableFuture<List<Partner>> _partners = ObservableFuture.value(null);

  ObservableFuture<List<Partner>> get partners => _partners;

  set userPartnerId(int userPartnerId) => _userPartnerId = userPartnerId;

  set currentIndex(int index) => _currentIndex = index;

  @action
  void loadPartners() {
    _partners = _partnerService.finAll().asObservable();
  }

  @action
  void like() {
    final items = _partners.value;
    final liked = items.removeAt(0);
    update(items);
    _relationService.sendLike(LikeDto(_userPartnerId, liked.id));
  }

  @action
  void deslike() {
    final items = _partners.value;
    final desliked = items.removeAt(0);
    update(items);
  }

  @action
  void update(List<Partner> items) {
    _partners = ObservableFuture.value(items);
  }
}
