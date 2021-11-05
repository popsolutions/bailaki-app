import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:odoo_client/app/data/models/channel.dart';
import 'package:odoo_client/app/data/services/channel_facade.dart';
import 'package:collection/collection.dart';
import 'package:odoo_client/app/data/services/channel_service.dart';
import 'package:odoo_client/app/data/services/odoo_api.dart';

part 'match_controller.g.dart';

class MatchController = _MatchControllerBase with _$MatchController;

abstract class _MatchControllerBase with Store {
  final ChannelFacade _channelFacade;
  final ChannelServiceImpl channelServiceImpl =
      ChannelServiceImpl(GetIt.I.get<Odoo>());

  int _currentPartnerId;

  set currentPartnerId(int currentPartnerId) =>
      _currentPartnerId = currentPartnerId;

  _MatchControllerBase(this._channelFacade);

  @observable
  ObservableFuture<List<Channel>> _matchesRequest =
      ObservableFuture.value(null);

  ObservableFuture<List<Channel>> get matchesRequest => _matchesRequest;

  @action
  void load() {
    _matchesRequest =
        _channelFacade.findByPartner(_currentPartnerId, true).asObservable();
  }

  @action
  void update() async {
    //Atualiza(Com o odoo) o amount_newmessages e lastMessage da lista de Channels (_matchesRequest.value)

    List<Channel> listChannel =
        await _channelFacade.findByPartner(_currentPartnerId, false);

    for (Channel channel in listChannel) {
      Channel channelFind = _matchesRequest.value.firstWhereOrNull(
          (element) => element.channelId == channel.channelId);

      if (channelFind == null) {
        channel.newChannel = true;
        await channelServiceImpl.setChannelImageOtherPartner(
            _currentPartnerId, channel);
        _matchesRequest.value.add(channel);
      } else {
        if (channel.amount_newmessages != channelFind.amount_newmessages)
          channelFind.amount_newmessages = channel.amount_newmessages;

        if (channel.lastMessage != channelFind.lastMessage)
          channelFind.lastMessage = channel.lastMessage;
      }
    }
  }
}
