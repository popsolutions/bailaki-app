import 'package:odoo_client/app/data/models/channel.dart';
import 'package:odoo_client/app/data/models/create_channel_dto.dart';
import 'package:odoo_client/app/data/models/memory_image.dart';
import 'package:odoo_client/app/data/services/odoo_api.dart';

abstract class ChannelService {
  Future<List<Channel>> findChannel(int partnerId, bool getImages);
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
  Future<List<Channel>> findChannel(int partnerId, bool getImages, [String channel_id = '']) async {
    if (channel_id != '')
      channel_id = '&channel_id=$channel_id';

    final channelsOdoo = await _odoo.getApi('bailaki/channels_amounts?partner_id=$partnerId&getImages=${getImages ? 'true' : 'false'}$channel_id');
    final channels = (channelsOdoo.getResponse() as List)
        ?.map<Channel>((e) => Channel.fromJson(e))
        ?.toList();

    return channels;
  }

  Future<void> setChannelImageOtherPartner(int partnerIdNot, Channel channel) async {
    PartnerChannel partnerChannel = channel.getPartnerOther(partnerIdNot);

    final imageResponse = await _odoo.searchRead('res.partner.image', [
        ['res_partner_id', '=', partnerChannel.id]
      ], ['image'], limit: 1);

      final List images = imageResponse.getRecords();

      if (images.isNotEmpty) {
        partnerChannel.photo = Photo.fromJsonImage(images[0]['image']);
      }
    }

}
