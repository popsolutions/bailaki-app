import 'package:odoo_client/app/data/models/channel.dart';
import 'package:odoo_client/app/data/models/create_channel_dto.dart';
import 'package:odoo_client/app/data/services/odoo_api.dart';

abstract class ChannelService {
  Future<List<Channel>> findByMatch(List<int> partnerIds);
  Future<void> save(CreateChannelDto createChannelDto);
}

class ChannelServiceImpl implements ChannelService {
  final Odoo _odoo;

  ChannelServiceImpl(this._odoo);

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

  @override
  Future<List<Channel>> findByMatch(List<int> partnerIds) async {
    final response = await _odoo.searchRead('mail.channel', [
      [
        'channel_partner_ids',
        'in',
        [partnerIds.first]
      ],
      [
        'channel_partner_ids',
        'in',
        [partnerIds.last]
      ]
    ], []);

    final List channels = response.getRecords();

    final channelPartners = await _odoo.searchRead('res.partner', [
      ['id', 'in', partnerIds],
    ], [
      'name',
      'id',
    ]);

    for (var channelPartner in channelPartners.getRecords()) {
      final imageResponse = await _odoo.searchRead('res.partner.image', [
        ['res_partner_id', '=', channelPartner['id']]
      ], []);

      final firstImage = imageResponse.getRecords().first;
      channelPartner['image'] = firstImage;
    }

    print(channelPartners);

    final items = channels
        .map<Channel>((channel) => Channel.fromJson(
            {...channel, 'partners': channelPartners.getRecords()}))
        .toList();

    return items;
  }
}
