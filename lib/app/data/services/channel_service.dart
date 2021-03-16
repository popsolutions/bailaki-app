import 'package:odoo_client/app/data/models/channel.dart';
import 'package:odoo_client/app/data/models/channel_request_dto.dart';
import 'package:odoo_client/app/data/models/create_channel_dto.dart';
import 'package:odoo_client/app/data/services/odoo_api.dart';

abstract class ChannelService {
  Future<List<Channel>> findByPartner(ChannelRequestDto channelRequestDto);
  Future<void> save(CreateChannelDto createChannelDto);
}

class ChannelServiceImpl implements ChannelService {
  final Odoo _odoo;

  ChannelServiceImpl(this._odoo);

  @override
  Future<List<Channel>> findByPartner(
      ChannelRequestDto channelRequestDto) async {
    final channels = (await _odoo.searchRead('mail.channel', [
     // ['id', '=', 15]
    ], []))
        .getRecords()
        .map<Channel>((e) => Channel.fromJson(e))
        .toList();
    return channels;
  }

  @override
  Future<void> save(CreateChannelDto createChannelDto) async {
    final channelres = await _odoo.create('mail.channel', {
      'description': 'chat',
      'name':
          '${createChannelDto.leftPartnerId},${createChannelDto.rightPartnerId}',
      'email_send': false,
      'channel_type': 'chat',
      'public': 'private',
      'channel_partner_ids': [
        [4, createChannelDto.leftPartnerId],
        [4, createChannelDto.rightPartnerId]
      ]
    });
    print(channelres);
  }
}