import 'package:odoo_client/app/data/models/channel.dart';
import 'package:odoo_client/app/data/services/channel_service.dart';
import 'package:odoo_client/app/data/services/match_service.dart';

class ChannelFacade {
  final MatchService _matchService;
  final ChannelService _channelService;

  ChannelFacade(this._channelService, this._matchService);

  Future<List<Channel>> findByPartner(int currentPartnerId, bool getImages) async {
    List<Channel> channels = await _channelService.findChannel(currentPartnerId, getImages);
    if (channels.isNotEmpty) {
      return channels;
    } else {
      return <Channel>[];
    }
  }
}
