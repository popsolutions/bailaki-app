import 'package:odoo_client/app/data/models/channel.dart';
import 'package:odoo_client/app/data/models/channel_request_dto.dart';
import 'package:odoo_client/app/data/services/channel_service.dart';
import 'package:odoo_client/app/data/services/match_service.dart';

class ChannelFacade {
  final ChannelService _channelService;

  ChannelFacade(this._channelService);

  Future<List<Channel>> findByPartner(int currentPartnerId) async {
    final channels = await _channelService
        .findByPartner(ChannelRequestDto(currentPartnerId: currentPartnerId));
    return channels;
  }
}
