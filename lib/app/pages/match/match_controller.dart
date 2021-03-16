import 'package:mobx/mobx.dart';
import 'package:odoo_client/app/data/models/channel.dart';
import 'package:odoo_client/app/data/services/channel_facade.dart';
part 'match_controller.g.dart';

class MatchController = _MatchControllerBase with _$MatchController;

abstract class _MatchControllerBase with Store {
  final ChannelFacade _channelFacade;
  int _currentPartnerId;

  set currentPartnerId(int currentPartnerId) => _currentPartnerId = currentPartnerId;

  _MatchControllerBase(this._channelFacade);

  @observable
  ObservableFuture<List<Channel>> _matchesRequest =
      ObservableFuture.value(null);

  ObservableFuture<List<Channel>> get matchesRequest => _matchesRequest;

  @action
  void load() {
    _matchesRequest =
        _channelFacade.findByPartner(_currentPartnerId).asObservable();
        
  }
}
