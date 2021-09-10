import 'package:odoo_client/app/data/models/channel.dart';
import 'package:odoo_client/app/data/services/channel_service.dart';
import 'package:odoo_client/app/data/services/match_service.dart';

class ChannelFacade {
  final MatchService _matchService;
  final ChannelService _channelService;

  ChannelFacade(this._channelService, this._matchService);

  Future<List<Channel>> findByPartner(int currentPartnerId) async {
    final matches = await _matchService.findAll(currentPartnerId);

    final channels = await Future.wait(matches.map((e) =>
        _channelService.findByMatch([e.leftPartnerId, e.rightPartnerId])));
    return channels.reduce((value, element) => value..addAll(element));
  }
}
