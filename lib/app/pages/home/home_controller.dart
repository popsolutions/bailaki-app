import 'package:geolocator/geolocator.dart';
import 'package:mobx/mobx.dart';
import 'package:odoo_client/app/data/models/deslike_dto.dart';
import 'package:odoo_client/app/data/models/like_dto.dart';
import 'package:odoo_client/app/data/pojo/partners.dart';
import 'package:odoo_client/app/data/services/partner_service.dart';
import 'package:odoo_client/app/data/services/relation_service.dart';
part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final PartnerService _partnerService;
  final RelationService _relationService;
  final Geolocator geolocator;
  int _userPartnerId;

  _HomeControllerBase(
      this._partnerService, this._relationService, this.geolocator);

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
    _relationService.sendDeslike(DeslikeDto(_userPartnerId, desliked.id));
  }

  @action
  void update(List<Partner> items) {
    _partners = ObservableFuture.value(items);
  }

  Future<Position> determinePosition() async {
    LocationPermission permission;

    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw LocationAccessException("Serviço de localização desabilitado");
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      throw LocationAccessException(
          "A permissão para o serviço de localização foi negada");
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        throw LocationAccessException("Permissão negada");
      }
    }

    return Geolocator.getCurrentPosition();
  }
}

class LocationAccessException implements Exception {
  final String message;

  LocationAccessException(this.message);
}
