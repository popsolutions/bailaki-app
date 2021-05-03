import 'package:odoo_client/app/data/models/channel.dart';
import 'package:odoo_client/app/data/models/channel_request_dto.dart';
import 'package:odoo_client/app/data/models/create_channel_dto.dart';
import 'package:odoo_client/app/data/services/odoo_api.dart';

abstract class ChannelService {
  Future<Channel> findByMatch(List<int> partnerIds);
  Future<List<Channel>> findByPartner(ChannelRequestDto channelRequestDto);
  Future<void> save(CreateChannelDto createChannelDto);
}

class ChannelServiceImpl implements ChannelService {
  final Odoo _odoo;

  ChannelServiceImpl(this._odoo);

  @override
  Future<List<Channel>> findByPartner(
      ChannelRequestDto channelRequestDto) async {
    final response = await _odoo.searchRead('mail.channel', [
      ['channel_partner_ids', 'in', channelRequestDto.currentPartnerId]
    ], []);

    final List channels = response.getRecords();

    final channelPartners = await _odoo.searchRead('res.partner', [
      [
        'id',
        'in',
        channels
            .map((e) => e['channel_partner_ids'])
            .expand((element) => element)
            .toSet()
            .toList(),
      ]
    ], [
      'name',
      'id',
    ]);
    print(channelPartners);

    final items = channels
        .map<Channel>((channel) => Channel.fromJson({
              ...channel,
              'partners': (channelPartners.getRecords() as List)
                  .where((e) => channel['channel_partner_ids']
                      .any((partnerId) => partnerId == e['id']))
                  .toList()
            }))
        .toList();

    return items;
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

  @override
  Future<Channel> findByMatch(List<int> partnerIds) async {
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
    print(channelPartners);

    final items = channels
        .map<Channel>((channel) => Channel.fromJson(
            {...channel, 'partners': channelPartners.getRecords()}))
        .toList();

    return items.last;
  }
}
