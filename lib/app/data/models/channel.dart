import 'package:odoo_client/app/data/models/memory_image.dart';

class Channel {
  final int channelId;
  final String name;
  final int leftPartnerId;
  final int rightPartnerId;
  final String lastMessage;
  final List<PartnerChannel> partners;

  Channel({
    this.channelId,
    this.name,
    this.leftPartnerId,
    this.rightPartnerId,
    this.lastMessage,
    this.partners,
  });

  PartnerChannel inverseChatter(int partnerId) {
    return partners.firstWhere((element) => element.id != partnerId,
        orElse: () => null);
  }

  factory Channel.fromJson(Map<String, dynamic> json) {
    return Channel(
      partners: json['partners']
          .map<PartnerChannel>((e) => PartnerChannel.fromJson(e))
          .toList(),
      name: json['name'],
      channelId: json['id'],
      lastMessage: json['lastMessage']?.replaceAll('<p>', '')?.replaceAll('</p>', ''),
      leftPartnerId: json['channel_partner_ids'].isNotEmpty
          ? json['channel_partner_ids'].first
          : null,
      rightPartnerId: json['channel_partner_ids'].isNotEmpty
          ? json['channel_partner_ids'].last
          : null,
    );
  }
}

class PartnerChannel {
  int id;
  String name;
  Photo photo;

  PartnerChannel({this.id, this.name});

  PartnerChannel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photo = Photo.fromJson(json['image']);
  }
}
