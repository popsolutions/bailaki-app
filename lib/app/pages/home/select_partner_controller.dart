//import 'package:location/location.dart';
import 'package:location/location.dart';
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
  final Location _locator;
  int _userPartnerId;

  _SelectPartnerControllerBase(this._partnerService, this._relationService,
      this._locator, this._sendLikeFacace);

  @observable
  ObservableFuture<List<Partner>> _partners = ObservableFuture.value(null);

  ObservableFuture<List<Partner>> get partners => _partners;

  set userPartnerId(int userPartnerId) => _userPartnerId = userPartnerId;

  @observable
  ObservableStream<LocationData> _currentLocation =
      Stream<LocationData>.empty().asObservable();

  ObservableStream<LocationData> get currentLocation => _currentLocation;

  @action
  void loadLocation() {
    _determineLocation();
  }

  Future<void> _determineLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _locator.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _locator.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await _locator.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _locator.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _currentLocation = _locator.onLocationChanged.asObservable();
  }

  @action
  void loadPartners() {
    _partners = _partnerService.finAll().asObservable();
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
